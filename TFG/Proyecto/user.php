<?php
include("php/DataBase.php");

$sql = "SELECT * FROM jugadores";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Jugadores</title>
<link rel="stylesheet" href="CSS/user.css">
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">⚽ Football Hub</div>

    <input type="text" id="search" placeholder="Buscar jugador...">

    <select id="filterClub">
        <option value="">Todos los clubes</option>
    </select>

    <select id="filterPosition">
        <option value="">Todas las posiciones</option>
        <option value="Portero">Portero</option>
        <option value="Defensa">Defensa</option>
        <option value="Centrocampista">Centrocampista</option>
        <option value="Delantero">Delantero</option>
    </select>
</div>

<!-- HERO -->
<div class="hero">
    <h1>Base de datos de jugadores</h1>
    <p>Filtra por club, posición o busca directamente</p>
</div>

<!-- GRID -->
<div class="container">

<div class="grid" id="players">

<?php while($r = $result->fetch_assoc()): ?>

<div class="card player"
     data-name="<?= strtolower($r["nombre"]) ?>"
     data-club="<?= $r["equipo"] ?>"
     data-position="<?= $r["posicion"] ?>">

    <div class="rank">⭐ <?= rand(60,99) ?></div>

    <img src="<?= $r["foto"] ? $r["foto"] : 'https://via.placeholder.com/300x180' ?>">

    <h3><?= $r["nombre"] ?></h3>
    <p><?= $r["equipo"] ?></p>
    <p><?= $r["posicion"] ?></p>

    <button onclick="openModal(
        '<?= $r["nombre"] ?>',
        '<?= $r["edad"] ?>',
        '<?= $r["equipo"] ?>',
        '<?= $r["posicion"] ?>'
    )">Ver perfil</button>

</div>

<?php endwhile; ?>

</div>
</div>

<!-- MODAL -->
<div id="modal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>

        <h2 id="mName"></h2>
        <p><b>Edad:</b> <span id="mAge"></span></p>
        <p><b>Club:</b> <span id="mClub"></span></p>
        <p><b>Posición:</b> <span id="mPos"></span></p>
    </div>
</div>

<script>

/* FILTER SYSTEM */
const search = document.getElementById("search");
const filterClub = document.getElementById("filterClub");
const filterPosition = document.getElementById("filterPosition");

const players = document.querySelectorAll(".player");

search.addEventListener("keyup", filterPlayers);
filterClub.addEventListener("change", filterPlayers);
filterPosition.addEventListener("change", filterPlayers);

function filterPlayers() {

    let text = search.value.toLowerCase();
    let club = filterClub.value;
    let pos = filterPosition.value;

    players.forEach(p => {

        let name = p.dataset.name;
        let clubData = p.dataset.club;
        let posData = p.dataset.position;

        let show =
            name.includes(text) &&
            (club === "" || clubData === club) &&
            (pos === "" || posData === pos);

        p.style.display = show ? "block" : "none";
    });
}

/* MODAL */
function openModal(name, age, club, pos) {
    document.getElementById("mName").innerText = name;
    document.getElementById("mAge").innerText = age;
    document.getElementById("mClub").innerText = club;
    document.getElementById("mPos").innerText = pos;
    document.getElementById("modal").style.display = "flex";
}

function closeModal() {
    document.getElementById("modal").style.display = "none";
}

</script>

</body>
</html>