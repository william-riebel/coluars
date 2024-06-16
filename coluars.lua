-- Customize output to the terminal using ANSI escape sequences
-- Written by William-Riebel June 2024
function create_style(foreground_color, background_color, is_bold, is_italic, is_underlined, is_double_underlined, is_inverse, is_overlined, is_struck) -- A function for convenience when creating style tables (names everything correctly).
    return {fg = foreground_color, bg = background_color, bold = is_bold, italic = is_italic, underline = is_underlined, double_underline = is_double_underlined, inverse = is_inverse, overline = is_overlined, struck = is_struck}
end


function convert_style(string, style) -- Adds ANSI control codes to a string to make it appear like defined in the style table
    local fgstring, bgstring = "", ""
    local formatstring = ""


    -- ANSI control codes to customize the text color
        -- color codes preconfigured in the terminal
    if (style["fg"] == "default") then
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
    else
        -- when the user inputs a custom color (3 numbers 0-255)
        fgstring = string.format("\27[38;2;%s;%s;%sm", style["fg"][1], style["fg"][2], style["fg"][3])
    end


    -- ANSI control codes to customize the background color
        -- color codes preconfigured in the terminal
    if (style["bg"] == "default") then
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
    else
        -- when the user inputs a custom color (3 numbers 0-255)
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
    if (style["overline"]) then -- double underlined text
        formatstring = formatstring .. "\27[53m"
    end
    if (style["struck"]) then -- struck through text
        formatstring = formatstring .. "\27[9m"
    end
    


    return string.format(fgstring .. bgstring .. formatstring .."%s\27[0m", string)
end


function print_style(string, style) -- Just saves time if you want to print with styling
    print(convert_style(string, style))
end

function remove_style(string)
    local a = string.find(string.reverse(string), "\27")
    string = string.sub(string, 1, -(a +1))
    local b = string.find(string.reverse(string), "\27")
    string = string.sub(string, string.len(string) -b+1, -1)
    local c = string.find(string, "m")
    string = string.sub(string, c + 1, -1)
    return string
end