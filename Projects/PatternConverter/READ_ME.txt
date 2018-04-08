PatternConverter: v.1.0
Author: James Clair
Date: 09/15/2015

This tool is designed to prepend and append wildcard "%" characters to the beginning and End of each line object in a list based text file.


Steps:

1. Create 'C:\Program Files\LogRhythm\LogRhythm Job Manager\config\list_import\PatternConverter' folder and Place source file and script in the new folder.
2. Run powershell script.
3. Enter Source Filename in UserInput box.
4. Output file should be in the "list_import" folder and ready for auto-import.


Use Case:

When using the auto list import functionality in LogRhythm there is the option to select Import Items as Patterns.  
This allows for any widcard characters "%" or "*" will be recognized as wildcards for sql based pattern searching and Regex searches.  
However there is not currently an efficient method for adding these characters if all items in a list are patterns.


Example:

Contents of example.txt before execution:
google.com
yahoo.com
bing.com

Contents of example.txt after execution:
%google.com%
%yahoo.com%
%bing.com%


