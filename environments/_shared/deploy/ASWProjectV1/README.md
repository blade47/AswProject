## Configurazione SERVER
*Posizionarsi nella cartella **DEPLOY / SERVER***

*Eseguire il comando:*
`sudo mvn clean install`

*Finita l'installazione esegui:*
`sudo mvn wildfly:deploy`

## Configurazione CLIENT
*Vai nella cartella **DEPLOY / SERVER** ed esegui il comando:*
`sudo mvn clean install`

*Finita l'installazione vai nella cartella **DEPLOY / CLIENT** ed esegui il comando:*
`sudo mvn clean install`

*Finita l'installazione esegui:*
`sudo mvn exec:exec`

