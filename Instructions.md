Technical Challenge for Postulation

Instruciones

Desarrolla una consola simple para manejar archivos y carpetas ingresando comandos por teclado, similar a Bash, por ejemplo.

Todos los recursos deben ser mantenidos en memoria y no persistidos a disco. Los archivos no necesita tener extensión pero deben tener metadata (la información de la metadata queda a tu criterio).

La forma recomendada para entrar a la consola desde el SO es:

ruby consola.rb

Comandos que soporta la consola:

**Archivos y carpetas

* Crear un archivo con un contenido
      create_file file_1 "Contenido"
      
* Ver el contenido de un archivo
    show file_1
    
* Ver la metadata de un archivo
    metadata file_1
    
* Crear una carpeta
    create_folder folder_1

* Entrar a una carpeta
    cd folder_1

* Volver una carpeta para atrás:
    cd ..

* Eliminar archivo o carpeta
    destroy file_1
    destroy folder_1

* Ver contenido de la carpeta actual
    ls

* Obtener la ruta de la carpeta actual
    whereami


**Usuarios y permisos

La consola no tiene seguridad por lo que se puede implementar un sistema de usuarios con varios roles:

* Superusuarios (super): pueden leer y crear archivos. También son los únicos que pueden crear y eliminar usuarios.
* Usuarios normales (regular): pueden leer y crear archivos y pueden editar su propia contraseña.
* Usuarios de solo lectura (read_only): solo pueden leer los archivos existentes. No pueden editar su propia contraseña.

* Crear un usuario nuevo como superusuario
    create_user username password -role=ready_only

* Actualizar contraseña del usuario actual
    update_password new_password
    
* Remover usuarios como superusuario
    destroy_user username
    
* Loguearte como usuario
    login username password
    
* Obtener nombre del usuario actual
    whoami
    
**Espacios de trabajo

Por defecto los archivos, las carpetas y los usuarios se mantienen solo en memoria, por lo que deben generarse de nuevo al empezar la aplicación y se eliminan al salir. Una mejora a la consola es poder darle un
parámetro a la consola cuando la inicias para que funcione con persistencia automática a un archivo. El formato para persistir la data queda a tu criterio.
Una posible forma de acceder a este modo desde el SO:

ruby consola.rb -persisted file
