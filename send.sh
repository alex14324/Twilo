#!/bin/bash
clear

merah='\e[91m'
cyan='\e[96m'
kuning='\e[93m'
oren='\033[0;33m' 
margenta='\e[95m'
biru='\e[94m'
ijo="\e[92m"
putih="\e[97m"
normal='\033[0m'
bold='\e[1m'
labelmerah='\e[41m'
labelijo='\e[42m'
labelkuning='\e[43m'
TwilliocURL(){
	twiliox=$(cat setting/twilio.txt | sort -R | head -1)
	subject=$(cat setting/bodysubject.txt | sort -R | head -1 | sed -f urlencode)
	gET=$(curl -skL --connect-timeout 30 --max-time 60 "https://interact.pk/app/api.php?send=$twiliox&body=$subject&to=${1}" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Accept-Language: id,en-US;q=0.7,en;q=0.3' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'TE: Trailers' -L)
}
TwiLiOSenD(){
	TwilliocURL $1 $twiliox $subject
	balance=$(echo $gET | grep -Po '(?<=Balance":)[^},]*' | tr -d '[]"' | sed 's/\(<[^>]*>\|<\/>\|{1|}\)//g')
	responX=$(echo $gET | grep -Po '(?<=error":)[^},]*' | tr -d '[]"' | sed 's/\(<[^>]*>\|<\/>\|{1|}\)//g')
	if [[ $responX =~ "200" ]]; then
		printf "${labelijo}-- SEND SUKSES --${normal} ${bold} ${1} - [$twiliox] $balance\n"
		echo "($twiliox) -$balance $Type">>twilioWORK.txt
	else
		printf "${labelmerah}-- SEND GAGAL --${normal} ${bold} ${1} [$twiliox]\n"
	fi
}
ProSeSTwilio(){
	TwiLiOSenD $1 $twiliox $subject
}
cat << "EOF"
                      .".
                     /  |
                    /  /
                   / ,"
       .-------.--- /
      "._ __.-/ o. o\
         "   (    Y  )
              )     /
             /     (
            /       Y
        .-"         |
       /  _     \    \
      /    `. ". ) /' )
     Y       )( / /(,/
    ,|      /     )
   ( |     /     /
    " \_  (__   (__        [vPwnd Tool V.3.0 - Twilio Priv8 ]
        "-._,)--._,)
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖    
⚜️ 𝑃𝑜𝑤𝑒𝑟𝑒𝑑 𝐵𝑦 @alex14324
⚜️ SUPPORT US!  >> https://t.me/alex14324
➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖
EOF
echo ""
read -p "Select Your List: " listo;
IFS=$'\r\n' GLOBIGNORE='*' command eval 'list=($(cat $listo))'
waktumulai=$(date +%s)
for (( i = 0; i <"${#list[@]}"; i++ )); do
	BAPAKKAU="${list[$i]}"
	IFS='' read -r -a array <<< "$BAPAKKAU"
	target=${array[0]}
	ProSeSTwilio $target
done
