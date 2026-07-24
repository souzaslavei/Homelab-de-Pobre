let modoRede = "LOCAL";


function alternarRede(){

    modoRede = modoRede === "LOCAL" ? "TAILSCALE" : "LOCAL";

    atualizarDashboard();

}


fetch("/api/identidade")
.then(response => response.json())
.then(identity => {

    document.title = identity.NOME_SERVIDOR;

    const name = document.getElementById("server-name");

    if (name) {
        name.textContent = identity.NOME_SERVIDOR;
    }

});


function atualizarDashboard(){

Promise.all([
fetch("/api/system").then(r => r.json()),
fetch("/api/enderecos").then(r => r.json())
]).then(([data, urls]) => {


const services = [

{
name:"SSH",
icon:"fa-solid fa-terminal",
status:data.SSH,
url:"#"
},

{
name:"FileBrowser",
icon:"fa-solid fa-folder",
status:data.FILEBROWSER,
url: modoRede === "LOCAL" ? urls.LOCAL_FILEBROWSER : urls.TAILSCALE_FILEBROWSER
},

{
name:"Transmission",
icon:"fa-solid fa-download",
status:data.TRANSMISSION,
url: modoRede === "LOCAL" ? urls.LOCAL_TRANSMISSION : urls.TAILSCALE_TRANSMISSION
},

{
name:"Jellyfin",
icon:"fa-solid fa-film",
status:data.JELLYFIN,
url: modoRede === "LOCAL" ? urls.LOCAL_JELLYFIN : urls.TAILSCALE_JELLYFIN
}

];


let html = `

<div class="network-switch">

<a class="button" href="#" onclick="alternarRede(); return false;">
<i class="${modoRede === "LOCAL" ? "fa-solid fa-house" : "fa-solid fa-globe"}"></i>
${modoRede === "LOCAL" ? "Rede Local" : "Tailscale"}
</a>

</div>

`;



html += '<div class="services">';


services.forEach(service => {

html += `

<div class="service-card">

<i class="${service.icon}"></i>

<div class="service-name">
${service.name}
</div>

<p class="${service.status === 'ONLINE' ? 'online':'offline'}">
${service.status}
</p>

${service.url !== "#" ?

`<a class="button" href="${service.url}" target="_blank">
Abrir
</a>`

: ""}

</div>

`;

});


html += "</div>";



html += `

<div class="info">




<h3 class="section-title">
Hardware
</h3>


<div class="hardware-grid">


<div class="hardware-card">

<i class="fa-solid fa-memory"></i>

<div class="hardware-title">
Memória RAM
</div>

<div class="hardware-value">
${data.RAM_PERCENT}
</div>

<div class="progress">
<div class="progress-bar" style="width:${data.RAM_PERCENT}">
</div>
</div>

<div class="hardware-description">
${data.RAM_USED} / ${data.RAM_TOTAL}
</div>

</div>



<div class="hardware-card">

<i class="fa-solid fa-hard-drive"></i>

<div class="hardware-title">
Armazenamento
</div>

<div class="hardware-value">
${data.STORAGE_PERCENT}
</div>

<div class="progress">
<div class="progress-bar" style="width:${data.STORAGE_PERCENT}">
</div>
</div>

<div class="hardware-description">
${data.STORAGE_USED} / ${data.STORAGE_TOTAL}
</div>

</div>



<div class="hardware-card">

<i class="fa-solid fa-microchip"></i>

<div class="hardware-title">
CPU
</div>

<div class="hardware-value">
${data.CPU_USAGE}
</div>

<div class="hardware-description">
${data.CPU_CORES} núcleos
</div>

</div>



<div class="hardware-card">

<i class="fa-solid fa-battery-three-quarters"></i>

<div class="hardware-title">
Bateria
</div>

<div class="hardware-value">
${data.BATTERY}
</div>

<div class="hardware-description">
${data.PLUGGED}
</div>

</div>



<div class="hardware-card">

<i class="fa-solid fa-temperature-half"></i>

<div class="hardware-title">
Temperatura
</div>

<div class="hardware-value">
${data.TEMPERATURE}
</div>

</div>


</div>


<div class="info">

<div class="info-item">
<span>${data.UPTIME}</span>
</div>

<div class="info-item">
<span>${data.UPDATED}</span>
</div>

</div>


</div>

`;



document.getElementById("status").innerHTML = html;


})


.catch(error => {

document.getElementById("status").innerHTML =
"Erro: " + error;

});

}


atualizarDashboard();
