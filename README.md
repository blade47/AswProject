# Asw_Project


## Le guide più significative consultate per utilizzare Wildfly con Vagrant ed effettuare il Deploy di un .war 

https://gist.github.com/sukharevd/6087988 <br />
https://kb.novaordis.com/index.php/Start_WildFly_as_a_systemd_Service_on_Linux <br />
http://support.elegantjbi.com/support/solutions/articles/9000108381-configuring-wildfly-as-a-service-in-linux <br />
https://stackoverflow.com/questions/42907443/wildfly-as-systemd-service <br />
https://github.com/Phidelux/vagrant-javaee-wildfly/blob/master/Vagrantfile <br />
https://github.com/Phidelux/vagrant-javaee-wildfly <br />
http://planet.jboss.org/post/vagrant_with_docker_provider_using_wildfly_and_java_ee_7_image <br />
https://github.com/Phidelux/vagrant-javaee-wildfly/blob/master/vagrant/conclusion.sh <br />

## Le guide più significative consultate per effettuare il porting di un'app EJB:

https://developer.jboss.org/people/fjuma/blog/2017/09/08/getting-started-with-ejbs-and-elytron-part-2 <br />
http://www.soluzionijava.it/index.php?option=com_content&view=article&id=109:lookup-remoto-di-un-ejb-30-session&catid=36:ejb&Itemid=66 <br />
https://developer.jboss.org/thread/276015 <br />
https://docs.jboss.org/author/display/AS71/EJB+invocations+from+a+remote+server+instance <br />
https://docs.oracle.com/javase/jndi/tutorial/beyond/env/source.html <br />
http://www.mastertheboss.com/jboss-server/jboss-as-7/jboss-as-7-remote-ejb-client-tutorial <br />
https://github.com/wildfly/quickstart/tree/master/ejb-remote <br />

<h2><a id="user-content-usage" class="anchor" aria-hidden="true" href="#usage"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>
Commenti riguardanti la prima fase del progetto (.WAR) </h2>

Durante la prima fase nella realizzazione del progetto il nostro obiettivo è stato quello di installare in maniera corretta Wildfly e farlo partire su una VM di prova. Il primo grande problema a cui si è andati incontro, è stato il fatto che eseguendo lo script di wildfly <code>standalone.sh</code>  la nostra bash rimaneva occupata dall'esecuzione di wildfly e non era possibile più utilizzarla.
Per rendere più comodo e immediato l'avvio dell'application server da parte dell'utente abbiamo consultato numerose guide (linkate in testa alla pagina), per far partire lo script di wildfly come un servizio, si è però notato che molte di esse modificavano file come <code>standalone.xml</code> o altri file di configurazione al fine di aggiungere variabili d'ambiente per funzionalità arricchite, che per il fine del progetto non erano necessarie. Abbiamo ovviato alla creazione di tale servizio realizzando uno script  <code>start-wildfly.sh</code>che fa partire wildfly in background attraverso una semplice linea di comando.
Fatto questo si è passati al deploy di una applicazione web Hello_World classica, non ancora buildata. Per il build abbiamo utilizzato Maven, poichè ha un canale preferenziale con wildfly. Attraverso Maven è possibile il deploy di un progetto buildato, direttamente usando la stringa di comando :
<code>mvn wildfly:deploy</code>
Per fornire una panoramica completa di come è possibile deployare un progetto in Wildfly, abbiamo scelto di non utilizzare questo comando, di cui ci avvarremo nel deploy dell'EJB, e deployare il progetto in maniera " Standard " cioè attraverso lo script fornito da wildfly chiamato <code>jboss-cli.sh</code> che si trova nella directory <code>/bin</code> di Wildfly.
Abbiamo, per l'appunto, buildato il progetto attraverso maven, preso il .war generato nella cartella di target e spostato nella cartella di Wildfly. Fatto questo attraverso il nostro script <code>deploy-project.sh</code> avviamo lo script jboss-cli.sh e deployamo il progetto.
Arriviamo all'ultima parte di questa prima fase, l'obiettivo ultimo era quello di eseguire correttamente il port forwarding, aver specificato la porta per il port forwarding sembrava non bastare. Per quanto riguarda i membri del gruppo che utilizzavano un Pc MacBook il port forwarding riusciva senza particolari intoppi, mentre chi utilizzava un sistema operativo Windows riscontrava numerosi problemi per visualizzare nel browser dell'host il corretto funzionamento degli script di start e deploy di Wildfly. 
Dopo numerose ricerche e settaggi vari (inutili) abbiamo scoperto che la causa del mancato port forwarding era l'antivirus di Windows Windows Defender. 
Una volta disattivato il port forwarding ha cominciato a funzionare anche per chi usava Windows.
Fatto questo ci siamo occupati di fare questa stessa cosa con Docker e tentare di deployare ed eseguire un progetto EJB

<h2><a id="user-content-usage" class="anchor" aria-hidden="true" href="#usage"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>
Commenti riguardanti la seconda fase del progetto (Docker) </h2>

Docker non ci ha causato troppi problemi, avendo risolto il problema del port forwarding è bastata qualche guida ( linkata in alto ) e una consultazione della documentazione ufficiale di docker (https://hub.docker.com/r/jboss/wildfly/
) per far partire tutto.

<h2><a id="user-content-usage" class="anchor" aria-hidden="true" href="#usage"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>
Commenti riguardanti la terza fase del progetto (Porting EJB) </h2>

Durante questa fase abbiamo passato un pò di tempo a cercare dei progetti EJB già svolti, di esempio,  che potessimo usare come riferimento per il nostro progetto.
Tra i tanti trovati, inizialmente nessuno di essi funzionava a dovere (alcuni non finivano con successo la build mentre altri fallivano la ricerca con JNDI). Ci siamo dunque concentrati sul capire quale fosse il problema, e dopo vari tentativi, tra cui cambiamenti di ip e modifiche al file /etc/host, abbiamo identificato il problema in un errore di configurazione del Vagrantfile; più precisamente assegnavamo un unico ip globale privato sia al server che al client (errore di sintassi dopo che abbiamo diviso la singola macchina developer in due macchine client e server). Risolto questo problema, sembrava che il client riuscisse ad arrivare al server, ma non aveva i permessi per accederci. Dunque, dopo aver consultato varie guide, abbiamo aggiunto un nuovo utente al server wildfly ed abbiamo aggiunto al file "wildfly-config.xml" le credenziali di accesso al server (wildfly elytron). Finalmente alcuni progetti (tra quelli trovati precedentemente) funzionavano. Ci siamo dunque concentrati a smembrare i progetti che funzionavano, per ridurli al minimo indispensabile e siamo giunti al progetto v1, perfettamente funzionante. Abbiamo proseguito cercando di semplificare ulteriormente la sintassi del codice: abbiamo aggiunto un file jndi.properties il quale si occupa dell'inizializzazione del contesto dell'applicazione ed abbiamo tolto dal client tutta l'implementazione delle interfacce lasciandoci solo le dichiarazioni dei metodi (progetto v3). Anche qui abbiamo utilizzato Maven in quanto integrato perfettamente con Wildfly. Tramite esso abbiamo integrato i plugin di Wildfly per Deploy ed Esecuzione veloci e la dipendenza tra il client e l'interfaccia del server. Come ultimo step volevamo effettuare il lookup del client al server tramite Injection, come fatto da lei nei progetti di esempio EJB. Purtroppo però i vari tentativi non sono andati bene, e quest'ultimo step non lo abbiamo completato. <br />
Abbiamo provato varie possibilità tra cui le guide:
https://stackoverflow.com/questions/43282192/how-to-specify-the-ejb-bean-name-in-the-jndi-tree-in-jee7 <br />
https://www.tutorialspoint.com/ejb/ejb_annotations.htm <br />
Senza però alcun successo. Il risultato è sempre NullPointer sulle classi dove dovrebbe esserci l'Injection della dipendenza.
Abbiamo quindi deciso di lasciare i metodi ad-hoc di lookup, i quali funzionano bene.

<h2><a id="user-content-usage" class="anchor" aria-hidden="true" href="#usage"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Configurazione Client/Server</h2>

Inizializzare il Client ed il Server:

*1. Posizionarsi nella cartella Developer ed eseguire:*
<pre><code> vagrant up </code></pre>

Nella macchina virtuale 'Server' viene automaticamente lanciata un'istanza di Wildfly.

*2. Finita la configurazione delle macchine virtuali è possibile accedere ad esse:*
<pre><code> vagrant ssh server/client </code></pre>

<h2><a id="user-content-usage" class="anchor" aria-hidden="true" href="#usage"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Test Deploy di un'applicazione .war</h2>

*1. Accedere al nodo 'Server':*
<pre></code> vagrant ssh server </pre></code>

*2. Andare nella cartella contenente il progetto:*
<pre><code> cd /home/asw/_shared/deploy </code></pre>

All'interno vi si trova un progetto di esempio denominato 'SpringBootBasic'

*3. Posizionarsi nella cartella del progetto:*
<pre><code> cd SpringBootBasic </pre></code>

*4. Generare il .war SpringBootBasic.war:*
<pre><code> mvn clean package </pre></code>

*5. Spostare il file SpringBootBasic.war nella cartella 'standalone' di Wildfly:*
<pre><code> sudo cp target/SpringBootBasic.war /usr/local/wildfly-13.0.0.Final/standalone/ </pre></code>

*6. Andare nella cartella contenente gli script:*
<pre><code> cd /home/asw/_shared/scripts </code></pre>

*7. Eseguire lo script 'deploy-project.sh':*
<pre><code> sudo sh deploy-project.sh </pre></code>

Questo script esegue il deploy di tutti i progetti nella cartella 'standalone' di Wildfly.

Finita l'esecuzione dello script si può testare la riuscita accedendo da host all'indirizzo: 
    http://0.0.0.0:8088/SpringBootBasic/hello/Professore

<h2><a id="user-content-usage" class="anchor" aria-hidden="true" href="#usage"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Test Docker</h2>

*1. Posizionarsi nella cartella Docker ed eseguire:*
<pre><code>vagrant up 
</code></pre>

*2. Finita la configurazione della macchina virtuale è possibile accedere ad essa:*
<pre><code>vagrant ssh docker
</code></pre>

*3. Posizionarsi nella cartella Dockerproject:*
<pre><code>cd dockerproject
</code></pre>

*4. Eseguire il comando:*
<pre><code>docker build --tag=wildfly .
</code></pre>

*5. In seguito, eseguire:*
<pre><code>docker run -p 8080:8080 -it wildfly
</code></pre>

Fatto questo possiamo vedere all'url : 
http://localhost:8081/
che Wildfly è correttamente funzionante e possiamo vedere anche che il progetto .war deployato funziona correttamente accedendo al seguente url :
http://localhost:8081/hello-world/hello


<h2><a id="user-content-usage" class="anchor" aria-hidden="true" href="#usage"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Test esecuzione App EJB</h2>


## Configurazione SERVER
*1. Posizionarsi nella cartella HOME / ASW / _SHARED / DEPLOY / ASWPROJECTV3 / SERVER:*
    <pre><code> cd /home/asw/_shared/deploy/ASWProjectV3/server </pre></code>

*2. Eseguire il comando:*
    <pre><code>sudo mvn clean install</code></pre>

*3. Finita l'installazione eseguire:*
    <pre><code>sudo mvn wildfly:deploy</code></pre>

## Configurazione CLIENT
*1. Posizionarsi nella cartella HOME / ASW / _SHARED / DEPLOY  / ASWPROJECTV3 / CLIENT / SERVERINTERFACE :*
    <pre><code> cd /home/asw/_shared/deploy/ASWProjectV3/client/serverinterface/ </pre></code>

*2. Eseguire il comando:*
    <pre><code>sudo mvn clean install</code></pre>
    
*3. Finita l'installazione posizionarsi nella cartella HOME / ASW / _SHARED / DEPLOY / ASWPROJECTV3 / CLIENT / CLIENT:* 
    <pre><code> cd /home/asw/_shared/deploy/AswProjectV3/client/client/ </pre></code>
    
*4. Eseguire il comando:*
    <pre><code>sudo mvn clean install</code></pre>

*5. Finita l'installazione eseguire:*
    <pre><code>sudo mvn exec:exec</code></pre>

Dovrebbero comparire sul terminale i messaggi inviati dal 'Client' le risposte del 'Server'.









