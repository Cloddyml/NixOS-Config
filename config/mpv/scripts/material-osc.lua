-- Material Design OSC для MPV
-- Поместить в ~/.config/mpv/scripts/material-osc.lua

local assdraw = require 'mp.assdraw'
local msg = require 'mp.msg'
local utils = require 'mp.utils'

-- ========== КОНФИГУРАЦИЯ ==========

local opts = {
    -- Цвета (будут перезаписаны из matugen)
    primary_color = "89B4FA",           -- Material Primary
    on_primary = "1E1E2E",              -- Text on primary
    surface = "313244",                 -- Surface color
    on_surface = "CDD6F4",              -- Text on surface
    
    -- Размеры
    bar_height = 3,                     -- Высота прогресс-бара
    seek_bar_height = 6,                -- Высота при наведении
    button_size = 32,                   -- Размер кнопок
    
    -- Поведение
    hidetimeout = 2000,                 -- Скрыть через 2 секунды
    fadeduration = 200,                 -- Длительность fade
    
    -- Позиция
    bar_margin = 8,                     -- Отступы от краёв
}

-- ========== СОСТОЯНИЕ ==========

local state = {
    showtime = nil,
    osc_visible = false,
    fullscreen = false,
    tick_timer = nil,
    hide_timer = nil,
    cache_state = nil,
    vo_mouse = true,
    mouse_in_osc = false,
}

-- ========== УТИЛИТЫ ==========

local function round(num)
    return math.floor(num + 0.5)
end

local function get_position()
    local pos = mp.get_property_number("time-pos", 0)
    local duration = mp.get_property_number("duration", 0)
    
    if duration == 0 then
        return 0
    end
    
    return (pos / duration) * 100
end

local function format_time(seconds)
    if not seconds then
        return "00:00:00"
    end
    
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    
    if hours > 0 then
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    else
        return string.format("%02d:%02d", minutes, secs)
    end
end

-- ========== РЕНДЕРИНГ ==========

local function render_progress_bar()
    local ass = assdraw.ass_new()
    local w = mp.get_property_number("osd-width")
    local h = mp.get_property_number("osd-height")
    
    local pos = get_position()
    local bar_width = w - (opts.bar_margin * 2)
    local bar_x = opts.bar_margin
    local bar_y = h - opts.bar_margin - opts.bar_height
    
    -- Фон прогресс-бара
    ass:new_event()
    ass:pos(0, 0)
    ass:append(string.format("{\\1c&H%s&\\1a&H80&}", opts.surface))
    ass:draw_start()
    ass:rect_cw(bar_x, bar_y, bar_x + bar_width, bar_y + opts.bar_height)
    ass:draw_stop()
    
    -- Заполненная часть
    if pos > 0 then
        local fill_width = (bar_width * pos) / 100
        ass:new_event()
        ass:pos(0, 0)
        ass:append(string.format("{\\1c&H%s&}", opts.primary_color))
        ass:draw_start()
        ass:rect_cw(bar_x, bar_y, bar_x + fill_width, bar_y + opts.bar_height)
        ass:draw_stop()
    end
    
    return ass.text
end

local function render_controls()
    local ass = assdraw.ass_new()
    local w = mp.get_property_number("osd-width")
    local h = mp.get_property_number("osd-height")
    
    -- Время текущее
    local time_pos = mp.get_property_number("time-pos", 0)
    local time_str = format_time(time_pos)
    
    ass:new_event()
    ass:pos(opts.bar_margin, h - opts.bar_margin - opts.bar_height - 30)
    ass:append(string.format("{\\fs20\\1c&H%s&}%s", opts.on_surface, time_str))
    
    -- Время общее
    local duration = mp.get_property_number("duration", 0)
    local duration_str = format_time(duration)
    
    ass:new_event()
    ass:pos(w - opts.bar_margin - 60, h - opts.bar_margin - opts.bar_height - 30)
    ass:append(string.format("{\\fs20\\1c&H%s&}%s", opts.on_surface, duration_str))
    
    -- Название файла
    local title = mp.get_property("media-title", "")
    if title then
        ass:new_event()
        ass:pos(w / 2, opts.bar_margin + 20)
        ass:append(string.format("{\\fs24\\1c&H%s&\\b1\\an5}%s", opts.on_surface, title))
    end
    
    return ass.text
end

local function render_osc()
    if not state.osc_visible then
        return ""
    end
    
    local result = render_progress_bar()
    result = result .. render_controls()
    
    return result
end

-- ========== ОБНОВЛЕНИЕ ==========

local function update_osc()
    local osc_text = render_osc()
    mp.set_osd_ass(mp.get_property_number("osd-width"), mp.get_property_number("osd-height"), osc_text)
end

local function show_osc()
    state.osc_visible = true
    state.showtime = mp.get_time()
    
    if state.hide_timer then
        state.hide_timer:kill()
    end
    
    state.hide_timer = mp.add_timeout(opts.hidetimeout / 1000, function()
        state.osc_visible = false
        update_osc()
    end)
    
    update_osc()
end

-- ========== СОБЫТИЯ ==========

local function mouse_move()
    if not state.vo_mouse then
        return
    end
    show_osc()
end

local function on_pause_change(name, paused)
    if paused then
        show_osc()
    end
end

local function tick()
    if state.osc_visible then
        update_osc()
    end
end

-- ========== ИНИЦИАЛИЗАЦИЯ ==========

local function init()
    -- Таймер для обновления
    state.tick_timer = mp.add_periodic_timer(0.5, tick)
    
    -- События
    mp.observe_property("pause", "bool", on_pause_change)
    mp.register_event("mouse-move", mouse_move)
    
    -- Начальное отображение
    show_osc()
    
    msg.info("Material OSC loaded")
end

mp.register_event("file-loaded", init)