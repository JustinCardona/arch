
PS3='Choose your CPU by entering a number: '
select CPU in intel amd other
do
    PS3='Choose your GPU by entering a number: '
    select GPU in nvidia amd other
    do
        break
    done
    break
done

curl -L https://raw.githubusercontent.com/JustinCardona/arch/master/1.sh > 1.sh
curl -L https://raw.githubusercontent.com/JustinCardona/arch/master/$CPU/$GPU/2.sh > 2.sh
sh 1.sh