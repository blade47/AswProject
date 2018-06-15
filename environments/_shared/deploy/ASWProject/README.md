# NEL SERVER
Posizionarsi nella cartella server

Eseguire il comando:
		sudo mvn clean install

Finita l'installazione esegui:
		sudo mvn wildfly:deploy

# NEL CLIENT
Vai nella cartella SERVER ed esegui il comando:
		sudo mvn clean install

Finita l'installazione vai nella cartella CLIENT ed esegui il comando:
		sudo mvn clean install

Finita l'installazione esegui:
		sudo mvn exec:exec