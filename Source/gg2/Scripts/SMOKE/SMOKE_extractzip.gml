// argument0 - Zip filename
// argument1 - Destination
// argument2 - Overwrite

var args;

args = 'e "'+argument0+'" -o"'+argument1+'"';

if (argument2) {
    args = args + ' -aoa';
}

execute_program("7za.exe", args, true);
