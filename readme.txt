
Utilizaremos los siguientes comandos:

"Write name and password"               => "name" "password"
"Persist files? (yes or no)"            => "yes" or "no"

"create_file" - Creates a file          => create_file "file_name" / "file_content"
"show" - Shows a file                   => show "file_name"
"metadata" - File's metadata            => metadata "file_name"
"destroy_file" - Destroy file           => destroy_file "file_name"
"create_folder" - Creates a folder      => create_folder "folder_name"
"cd" - Go to folder                     => cd "folder_name"
"cd.." - Previous folder                => cd..
"ls" - Shows folder files               => ls
"whereami" - Path of current folder     => whereami
"destroy_folder" - Destroy folder       => destroy_folder "folder_name"
"create_user" - Creates read_only User  => create_user "user_name"
"update_password" - Updates password    => update_password "new_password"
"ls_users" - Shows ls_users             => ls_users
"whoami" - Shows actual user name       => whoami
"destroy_user" - Destroy user           => destroy_user "user_name"
"change_session" - Changes user session => change_session
"help" - Shows commands                 => help
"quit" - Exit                           => quit