#!/bin/sh
# Executa na CRON a cada 30 minutos.
# Caminho: /etc/rc.dyndns.force.update 
# CRON: */30	*	*	*	*	root	/usr/bin/nice -n20 /etc/rc.force.dyndns.update
# Comando que renova: /etc/rc.dyndns.update 

# Preencha aqui com seu host DDNS
meuHost=""

# "XXXXXXXX IP ATUAL XXXXXXXX"
IP_atual=`dig +short myip.opendns.com @resolver1.opendns.com`
IP_atual_retorno=$?

# "XXXXXXXX IP NoIP XXXXXXXX"
IP_NoIP=`dig $meuHost | grep -A1 ANSWER | grep IN | cut -f 6`

if [ "$IP_atual" == "$IP_NoIP" ] ; then
    # "IPs iguais, entao saio."
    exit
else
# Se entrei aqui, entao o meu IP nao esta igual o NoIP.
# Vou testar se esta com rede, se nao esta eu cancelo...

    # "XXXXXXXX TESTE DE REDE XXXXXXXX"
    if [ "$IP_atual_retorno" -eq 0 ]
        then
            # Consegui conectar, o retorno deu 0. Entao posso prosseguir
            /etc/rc.dyndns.update
        else
            # Se cheguei aqui sinal que deu ERRO. Eu saio... Pode estar sem rede ou com outro erro.
            # Cancelo.
            exit
    fi
fi