#!/bin/bash
#===============HEADER======================================|
#AUTOR
#  Jefferson Rocha <root@slackjeff.com.br>
#
#PROGRAMA
#  Listagem de pacotes no slackware utilizando o diretorio
#  padrão /var/log/packages/
#===========================================================|
[[ "$1" ]] || { echo "Enter name package."; exit 1 ;}

#======VARS
dir='/var/log/packages/'
#======COR
red="\033[31;1m"
end="\033[m"

#======FUNCOES
_LIST()
{
   cd "$dir" # entrando no diretorio
   for archive in *; do
      if [[ "$archive" =~ ^${1}-.*[0-9] ]]; then
         #Pegando tamanho dos campos
         number_of_fields=$(echo $archive | \
         gawk -F "-" '{ split($0,fields); print length(fields) }')
         if [[ "$number_of_fields" = "5" ]]; then
            name=$(echo $archive | cut -d - -f 1,2)
            version=$(echo $archive | cut -d - -f 3)
            arch=$(echo $archive | cut -d - -f 4)
            build=$(echo $archive | cut -d - -f 5)
         else
            name=$(echo $archive | cut -d - -f 1)
            version=$(echo $archive | cut -d - -f 2)
            arch=$(echo $archive | cut -d - -f 3)
            build=$(echo $archive | cut -d - -f 4)
         fi
         echo -e "${red}Package:${end} ${name} ${red}Version:${end} ${version} ${red}Arch:${end} ${arch} ${red}Build:${end} ${build}"
         return 0
      fi
   done # Main
}

_LIST "$@"
