#!/bin/bash

if ! [ -x "mytar" ]; then
	echo "El programa mytar no se encuentra en el directorio."
else
	if [ -d "tmp" ]; then
		rm -r tmp
	fi
	mkdir tmp
	cd tmp
	touch file1.txt
	echo "Hello world!" > file1.txt
	touch file2.txt
	head /etc/passwd > file2.txt
	touch file3.dat
	head -c 1024 /dev/urandom > file3.dat
	../mytar -cf filetar.mtar file1.txt file2.txt file3.dat
	mkdir out
	cp filetar.mtar out
	cd out
	../../mytar -xf filetar.mtar
	if ! diff file1.txt ../file1.txt; then
		cd ../..
		echo "Fallo al comparar file1.txt"
		exit 1;
	fi
	if ! diff file2.txt ../file2.txt; then
		cd ../..
		echo "Fallo al comparar file2.txt"
		exit 1;
	fi
	if ! diff file3.dat ../file3.dat; then
		cd ../..
		echo "Fallo al comparar file3.dat"
		exit 1;
	fi
	cd ../..
	echo "Correct"
	exit 0
fi
