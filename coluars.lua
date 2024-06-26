-- Customize output to the terminal using ANSI escape sequences
-- Written by William-Riebel June 2024

function convert_style(string, style) -- Adds ANSI control codes to a string to make it appear like defined in the style table
    local fgstring, bgstring = "", ""
    local formatstring = ""


    -- ANSI control codes to customize the text color
        -- color codes preconfigured in the terminal
    if (style["fg"] == "default" or style["fg"] == nil or style["fg"] == "") then
        fgstring = "\27[39m"
    elseif (style["fg"] == "black") then
        fgstring = "\27[30m"
    elseif (style["fg"] == "red") then
        fgstring = "\27[31m"
    elseif (style["fg"] == "green") then
        fgstring = "\27[32m"
    elseif (style["fg"] == "yellow") then
        fgstring = "\27[33m"
    elseif (style["fg"] == "blue") then
        fgstring = "\27[34m"
    elseif (style["fg"] == "magenta") then
        fgstring = "\27[35m"
    elseif (style["fg"] == "cyan") then
        fgstring = "\27[36m"
    elseif (style["fg"] == "white") then
        fgstring = "\27[37m"
    elseif (style["fg"] == "bright_black" or style["bg"] == "grey") then
        fgstring = "\27[90m"
    elseif (style["fg"] == "bright_red") then
        fgstring = "\27[91m"
    elseif (style["fg"] == "bright_green") then
        fgstring = "\27[92m"
    elseif (style["fg"] == "bright_yellow") then
        fgstring = "\27[93m"
    elseif (style["fg"] == "bright_blue") then
        fgstring = "\27[94m"
    elseif (style["fg"] == "bright_magenta") then
        fgstring = "\27[95m"
    elseif (style["fg"] == "bright_cyan") then
        fgstring = "\27[96m"
    elseif (style["fg"] == "bright_white") then
        fgstring = "\27[97m"
    elseif (type(style["fg"]) == "table") then -- when the user inputs a custom color code (table containing 3 numbers 0-255)
        fgstring = string.format("\27[38;2;%s;%s;%sm", style["fg"][1], style["fg"][2], style["fg"][3])
    end


    -- ANSI control codes to customize the background color
        -- color codes preconfigured in the terminal
    if (style["bg"] == "default" or style["bg"] == nil or style["bg"] == "") then
        bgstring = "\27[49m"
    elseif (style["bg"] == "black") then
        bgstring = "\27[40m"
    elseif (style["bg"] == "red") then
        bgstring = "\27[41m"
    elseif (style["bg"] == "green") then
        bgstring = "\27[42m"
    elseif (style["bg"] == "yellow") then
        bgstring = "\27[43m"
    elseif (style["bg"] == "blue") then
        bgstring = "\27[44m"
    elseif (style["bg"] == "magenta") then
        bgstring = "\27[45m"
    elseif (style["bg"] == "cyan") then
        bgstring = "\27[46m"
    elseif (style["bg"] == "white") then
        bgstring = "\27[47m"
    elseif (style["bg"] == "bright_black" or style["bg"] == "grey") then
        bgstring = "\27[100m"
    elseif (style["bg"] == "bright_red") then
        bgstring = "\27[101m"
    elseif (style["bg"] == "bright_green") then
        bgstring = "\27[102m"
    elseif (style["bg"] == "bright_yellow") then
        bgstring = "\27[103m"
    elseif (style["bg"] == "bright_blue") then
        bgstring = "\27[104m"
    elseif (style["bg"] == "bright_magenta") then
        bgstring = "\27[105m"
    elseif (style["bg"] == "bright_cyan") then
        bgstring = "\27[106m"
    elseif (style["bg"] == "bright_white") then
        bgstring = "\27[107m"
    elseif (type(style["bg"]) == "table") then -- when the user inputs a custom color code (table containing 3 numbers 0-255)
        bgstring = string.format("\27[48;2;%s;%s;%sm", style["bg"][1], style["bg"][2], style["bg"][3])
    end


    -- Adds ANSI control codes for styling
    if (style["inverse"]) then -- inverse text
        formatstring = formatstring .. "\27[7m"
    end
    if (style["bold"]) then -- bold text
        formatstring = formatstring .. "\27[1m"
    end
    if (style["italic"]) then -- italic text
        formatstring = formatstring .. "\27[3m"
    end
    if (style["underline"]) then -- underlined text
        formatstring = formatstring .. "\27[4m"
    end
    if (style["double_underline"]) then -- double underlined text
        formatstring = formatstring .. "\27[21m"
    end
    if (style["overline"]) then -- overlined text
        formatstring = formatstring .. "\27[53m"
    end
    if (style["struck"]) then -- struck through text
        formatstring = formatstring .. "\27[9m"
    end
    if (style["blink"]) then -- blinking text
        formatstring = formatstring .. "\27[5m"
    end
    

    return string.format(fgstring .. bgstring .. formatstring .."%s\27[0m", string)
end


function write_style(string, style) -- Just saves time if you want to print with styling
    io.write(convert_style(string, style))
end


function remove_style(string) -- This function removes the ANSI escape sequences added to a string by this module and returns the string. This will break if you add your own ANSI escape sequences to the string without using this module or if you input multiple concatinated, styled strings.
    local index = string.find(string.reverse(string), "\27")
    string = string.sub(string, 1, -(index +1))
    index = string.find(string.reverse(string), "\27")
    string = string.sub(string, string.len(string) -index+1, -1)
    index = string.find(string, "m")
    string = string.sub(string, index + 1, -1)
    return string
end


function reset_style() -- This just prints the ANSI escape sequence to reset the current treminal instance. I reccomend using it at every exit point of your program. Currently this is not neccessary, since this module does not include functionality that may break out of a string.
    io.write("\27[0m")
end


function move_cursor(delta_x, delta_y) -- Moves the cursor relative to its current position. If the cursor is already at the edge of the screen this does not move it outside
    local move_code = ""
    if (delta_x < 0) then
        move_code = move_code .. string.format("\27[%sD", math.abs(delta_x))
    elseif (delta_x > 0) then
        move_code = move_code .. string.format("\27[%sC", delta_x)
    end
    if (delta_y < 0) then
        move_code = move_code .. string.format("\27[%sA", math.abs(delta_y))
    elseif (delta_y > 0) then
        move_code = move_code .. string.format("\27[%sB", delta_y)
    end
    io.write(move_code)
end


function set_cursor(x, y)
    io.write(string.format("\27[%s;%sH", y, x))
end


function scroll(lines)
    local string = ""
    if lines < 0 then
        string = string.format("\27[%sS", (lines * -1))
    elseif lines > 0 then
        string = string.format("\27[%sS", lines)
    end
    io.write(string)
end


function clear_screen(arg) -- Clears the screen up realitve to the cursor, down relative to the cursor or the entire screen
    if (arg == nil or arg == "all") then
        io.write("\27[2J")
    elseif (arg == "up") then
        io.write("\27[1J")
    elseif (arg == "down") then
        io.write("\27[0J")
    end
end


function clear_line(arg)
    if (arg == nil or arg == "all") then
        io.write("\27[2K")
    elseif (arg == "left") then
        io.write("\27[1K")
    elseif (arg == "right") then
        io.write("\27[0K")
    end
end