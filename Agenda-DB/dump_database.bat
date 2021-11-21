:begin
@echo off

SET backup_path=C:\backup
@REM Variables de conexión
SET host=ec2-52-209-134-160.eu-west-1.compute.amazonaws.com
SET db=dd30civl4s1bgh
SET user=wpzyecjyrvvhca
SET PGPASSWORD=4f43c6e7b19404e7cc1a8fd6df2f5f2abb8bfc71758789bbcbd2309214af68cf
SET dump_exec="C:\Program Files\PostgreSQL\14\bin\pg_dump.exe"  
SET schema_flags=--schema=dd30civl4s1bgh --format=p
SET dump_flags=--blobs --verbose --data-only --format=p

@REM Recupera la fecha actual
for /F "tokens=1-4 delims=/ " %%i in ('date /t') do (
    set datestr=%%l-%%k-%%j
    set D=%%j
    set M=%%k
    set Y=%%l
)
SET BACKUP_FILE=%datestr%.sql.bak
SET DATA_FILE=data.sql
SET SCHEMA_FILE=schema.sql

@REM Comprobar directorio de archivos
if not exist %backup_path% (
    mkdir %backup_path%
    mkdir %backup_path%\data
    mkdir %backup_path%\schema
)

@REM Recupera el schema si no existe
set schema=false
if not exist %backup_path%\%SCHEMA_FILE% schema=true
if D=="1" schema=true
if schema ==true (
    if exist %backup_path%\%SCHEMA_FILE% move %backup_path%\%SCHEMA_FILE% %backup_path%\schema\%BACKUP_FILE%
    %dump_exec% --host=%host% -U %user% %schema_flags% -f %backup_path%\%SCHEMA_FILE%  %db% 
)
@REM Mueve los úlitmos datos al histórico
if exist %backup_path%\%DATA_FILE% move %backup_path%\%DATA_FILE% %backup_path%\data\%BACKUP_FILE%

@REM Recuepra los datos
%dump_exec% --host=%host% -U %user% %dump_flags% -f %backup_path%\%DATA_FILE%  %db% 

echo "FIN DE EJECUCION"
:end
