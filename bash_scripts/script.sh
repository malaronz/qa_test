#!/bin/bash

echo "Введите количество файлов, которые нужно создать:"
read num_files

echo "Введите название файла (с расширением):"
read filename

echo "Введите путь для сохранения файлов:"
read path

for i in $(seq 1 $num_files); do
    file_name="${filename%.*}$i.${filename##*.}"
    touch "$path/$file_name"
    echo "Файл $file_name создан в $path"
done
