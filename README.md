# Asw_Project


## Le guide più significative consultate per utilizzare Wildfly con Vagrant ed effettuare il Deploy di un .war 

`https://gist.github.com/sukharevd/6087988`
`https://kb.novaordis.com/index.php/Start_WildFly_as_a_systemd_Service_on_Linux`
`http://support.elegantjbi.com/support/solutions/articles/9000108381-configuring-wildfly-as-a-service-in-linux`
`https://stackoverflow.com/questions/42907443/wildfly-as-systemd-service`
`https://github.com/Phidelux/vagrant-javaee-wildfly/blob/master/Vagrantfile`
`https://github.com/Phidelux/vagrant-javaee-wildfly`
`http://planet.jboss.org/post/vagrant_with_docker_provider_using_wildfly_and_java_ee_7_image`
`https://github.com/Phidelux/vagrant-javaee-wildfly/blob/master/vagrant/conclusion.sh`

## Le guide più significative consultate per effettuare il porting di un'app EJB:

`https://developer.jboss.org/people/fjuma/blog/2017/09/08/getting-started-with-ejbs-and-elytron-part-2`
`http://www.soluzionijava.it/index.php?option=com_content&view=article&id=109:lookup-remoto-di-un-ejb-30-session&catid=36:ejb&Itemid=66`
`https://developer.jboss.org/thread/276015`
`https://docs.jboss.org/author/display/AS71/EJB+invocations+from+a+remote+server+instance`
`https://docs.oracle.com/javase/jndi/tutorial/beyond/env/source.html`
`http://www.mastertheboss.com/jboss-server/jboss-as-7/jboss-as-7-remote-ejb-client-tutorial`
`https://github.com/wildfly/quickstart/tree/master/ejb-remote`

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

*2. Andare nella cartella contenente gli script:*
<pre><code> cd /home/asw/_shared/script </code></pre>

All'interno vi si trova un progetto di esempio denominato 'SpringBootBasic'

*3. Posizionarsi nella cartella del progetto:*
<pre><code> cd SpringBootBasic </pre></code>

*4. Generare il .war SpringBootBasic.war:*
<pre><code> mvn clean package </pre></code>

*5. Spostare il file SpringBootBasic.war nella cartella 'standalone' di Wildfly:*
<pre><code> sudo cp /SpringBootBasic/target/SpringBootBasic.war /usr/local/wildfly-13.0.0.Final/standalone/ </pre></code>

*6. Andare nella cartella contenente gli script:*
<pre><code> cd /home/asw/_shared/script </code></pre>

*7. Eseguire lo script 'deploy-project.sh':*
<pre><code> sudo sh deploy-project.sh </pre></code>

Questo script esegue il deploy di tutti i progetti nella cartella 'standalone' di Wildfly.

Finita l'esecuzione dello script si può testare la riuscita accedendo da host all'indirizzo: 
    `http://0.0.0.0:8088/SpringBootBasic/hello/Professore`

<h2><a id="user-content-usage" class="anchor" aria-hidden="true" href="#usage"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>Test esecuzione App EJB</h2>

## Configurazione SERVER
*1. Posizionarsi nella cartella HOME / ASW / _SHARED / DEPLOY / SERVER:*
    <pre><code> cd /home/asw/_shared/deploy/server </pre></code>

*2. Eseguire il comando:*
    <pre><code>sudo mvn clean install</code></pre>

*3. Finita l'installazione eseguire:*
    <pre><code>sudo mvn wildfly:deploy</code></pre>

## Configurazione CLIENT
*1. Posizionarsi nella cartella HOME / ASW / _SHARED / DEPLOY  / CLIENT / SERVERINTERFACE :*
    <pre><code> cd /home/asw/_shared/deploy/client/serverinterface/ </pre></code>

*2. Eseguire il comando:*
    <pre><code>sudo mvn clean install</code></pre>
    
*3. Finita l'installazione posizionarsi nella cartella HOME / ASW / _SHARED / DEPLOY / CLIENT / CLIENT:* 
    <pre><code> cd /home/asw/_shared/deploy/client/client/ </pre></code>
    
*4. Eseguire il comando:*
    <pre><code>sudo mvn clean install</code></pre>

*5. Finita l'installazione eseguire:*
    <pre><code>sudo mvn exec:exec</code></pre>

Dovrebbero comparire sul terminale i messaggi inviati dal 'Client' le risposte del 'Server'.









