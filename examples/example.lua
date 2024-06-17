-- WARNING: The examples shown here are out of date

-- An example script to show off the functions of this module.
-- To use this module, copy the required files to your project folder and include them in your code with "require".
-- Like this:
require("coluars")

-- Now you are ready to use the functions that this module provides.


-- When styling Text using this module you will need a "style table".
-- The style table contains all the necessary information to display your text.
-- It contains the text color, the background color and if the text is bold, italic, underlined, double underlined and inversed.
-- The name of the style table does not matter but the names of the variables it contains does.
-- A style table looks like this:

example_style = {
    fg = {255, 255, 0},        -- Foreground or text color (string or a table containing three nubers 0-255)
    bg = "cyan",               -- Background color         (string or a table containing three nubers 0-255)
    bold = true,               -- Bold or not              (boolian)
    italic = false,            -- Italic or not            (boolian)
    underline = false,         -- Underlined or not        (boolian)
    double_underline = false,  -- Double underlined or not (boolian)
    struck = false,
    overline = false,
    inverse = false
    }

-- Notice that there are two ways colors are represented here.
-- Firstly, there is the color beeing represented by three numbers from 0 to 255.
-- This works intuitively, just like you would expect.
-- The three numbers represent the red, green and blue color channels.
--
-- Secondly, there is a string containing the name of a color.
-- There are eight predetermined colors and their bright variants.
--     "black"
--     "red"
--     "green"
--     "yellow"
--     "blue"
--     "magenta"
--     "cyan"
--     "white"
--     "bright_black" ((dark grey), just named "bright_black" for consitency)
--     "bright_red"
--     "bright_green"
--     "bright_yellow"
--     "bright_blue"
--     "bright_magenta"
--     "bright_cyan"
--     "bright_white"
--
--     "default" (this is just the terminals default color scheme but is treated just like a color)
--
-- Notice that the way in which these colors are displayed is determined by the terminal that is displaying them.
-- If, for some reason, someones terminal displays "green" with a color that isnt green this program will also use this color instead of green.
-- This usually does not matter but if you need a color to be represented accurately you can just use the other method of giving the exact color.
--
--
-- For greater convenience when making style tables you can use the "create_style" function.
-- It is not necessary to use this function when creating a style table, it is just convenient since it names all the variables contained in the style table correctly.

--second_example_style = create_style("red", "default", false, false, true, false, true, false, false)
--                                    |        |        |      |      |     |      |     |      |
--                                    |        |        |      |      |     |      |     |      |
--                    [foreground color]       |        |      |      |     |      |     |      |
--                                             |        |      |      |     |      |     |      |
--                             [background color]       |      |      |     |      |     |      |
--                                                      |      |      |     |      |     |      |
--                                                  [bold]     |      |     |      |     |      |
--                                                             |      |     |      |     |      |
--                                                       [italic]     |     |      |     |      |
--                                                                    |     |      |     |      |
--                                                           [underline]    |      |     |      |
--                                                                          |      |     |      |
--                                                          [double underline]     |     |      |
--                                                                                 |     |      |
--                                                                          [inverse]    |      |
--                                                                                       |      |
--                                                                               [overline]     |
--                                                                                              |
--                                                                                       [inverse]


-- Now that you know how to make correct style tables, let us use those tables to make some colored text.
-- Since this module works by just adding some special characters to a string, you can convert any string into a string with styling by using the "convert_style" function.
-- Here is some example code, I recommend executing it in your terminal to see what it does.

example_string = "Just some text that is about to be styled."

print(example_string) -- before using the convert_style function

example_string = convert_style(example_string, example_style) -- using the convert_style function on example_string with example_style

print(example_string) -- after using the convert_style function

-- For more convenience you can also use the "print_style" function if you just want to print a single string in a single style.
-- This does not allow for as much freedom as the method mentioned above but it is convenient and works just as well.

print_style("I am lazy", example_style)

-- That is about it for the explanation of the current set of functions that this module provides. Now I would like to show of some funky text to get you inspired.
-- For example, you can mix different styles in a single string since the convert style function is implemented in a way, where it just adds some special characters at the beginning and end of a string.
-- Just look at the output of this:

print("Just some regular text with an " .. convert_style("important", exam) .. " word.\27[")