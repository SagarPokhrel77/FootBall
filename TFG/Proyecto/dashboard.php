<?php
session_start();
include("php/DataBase.php");

if (!isset($_SESSION["user_id"]) || $_SESSION["rol"] == 3) {
    header("Location: login.php");
    exit();
}

/* ================= CONFIG ================= */
$basePath = "uploads/";

/* ================= ADD ================= */
if (isset($_POST["add"])) {

    $nombre = $_POST["nombre"];
    $edad = $_POST["edad"];
    $posicion = $_POST["posicion"];
    $equipo = $_POST["equipo"];
    $rating = $_POST["rating"];

    $foto = null;

    if (isset($_FILES["foto"]) && $_FILES["foto"]["error"] === 0) {

        $fileName = basename($_FILES["foto"]["name"]);
        $path = $basePath . $fileName;

        move_uploaded_file($_FILES["foto"]["tmp_name"], $path);

        $foto = $path;
    }

    $stmt = $conn->prepare("
        INSERT INTO jugadores (nombre, edad, posicion, equipo, foto, rating)
        VALUES (?,?,?,?,?,?)
    ");

    $stmt->bind_param("sisssi", $nombre, $edad, $posicion, $equipo, $foto, $rating);
    $stmt->execute();

    header("Location: dashboard.php");
    exit();
}

/* ================= UPDATE ================= */
if (isset($_POST["update"])) {

    $id = $_POST["id"];
    $nombre = $_POST["nombre"];
    $edad = $_POST["edad"];
    $posicion = $_POST["posicion"];
    $equipo = $_POST["equipo"];
    $rating = $_POST["rating"];

    // current image + rating
    $stmt = $conn->prepare("SELECT foto FROM jugadores WHERE id=?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $res = $stmt->get_result()->fetch_assoc();

    $foto = $res["foto"] ?? null;

    if (isset($_FILES["foto"]) && $_FILES["foto"]["error"] === 0) {

        if ($foto && file_exists($foto)) {
            unlink($foto);
        }

        $fileName = basename($_FILES["foto"]["name"]);
        $path = $basePath . $fileName;

        move_uploaded_file($_FILES["foto"]["tmp_name"], $path);

        $foto = $path;
    }

    $stmt = $conn->prepare("
        UPDATE jugadores 
        SET nombre=?, edad=?, posicion=?, equipo=?, foto=?, rating=?
        WHERE id=?
    ");

    $stmt->bind_param("sisssii", $nombre, $edad, $posicion, $equipo, $foto, $rating, $id);
    $stmt->execute();

    header("Location: dashboard.php");
    exit();
}

/* ================= DELETE ================= */
if (isset($_POST["delete_id"])) {

    $id = $_POST["delete_id"];

    $stmt = $conn->prepare("SELECT foto FROM jugadores WHERE id=?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $img = $stmt->get_result()->fetch_assoc()["foto"] ?? null;

    if ($img && file_exists($img)) {
        unlink($img);
    }

    $stmt = $conn->prepare("DELETE FROM jugadores WHERE id=?");
    $stmt->bind_param("i", $id);
    $stmt->execute();

    header("Location: dashboard.php");
    exit();
}

$result = $conn->query("SELECT * FROM jugadores");
?>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="CSS/dashboard.css">
</head>

<body>

<div class="navbar">
    ⚽ ADMIN PANEL
    <span><?= $_SESSION["user"] ?></span>
</div>

<div class="container">

<div class="sidebar">
    <button onclick="openAdd()">➕ Añadir jugador</button>
</div>

<div class="content">

<div class="card">

<h2>Jugadores</h2>

<table>
<tr>
    <th>Foto</th>
    <th>Nombre</th>
    <th>Edad</th>
    <th>Posición</th>
    <th>Equipo</th>
    <th>Rating</th>
    <th>Acciones</th>
</tr>

<?php while($r = $result->fetch_assoc()): ?>
<tr>

<td>
<img src="<?= htmlspecialchars($r['foto']) ?>" width="60">
</td>

<td><?= $r["nombre"] ?></td>
<td><?= $r["edad"] ?></td>
<td><?= $r["posicion"] ?></td>
<td><?= $r["equipo"] ?></td>

<td>⭐ <?= $r["rating"] ?>/99</td>

<td>
    <button onclick="openEdit(
        '<?= $r['id'] ?>',
        '<?= $r['nombre'] ?>',
        '<?= $r['edad'] ?>',
        '<?= $r['posicion'] ?>',
        '<?= $r['equipo'] ?>',
        '<?= $r['rating'] ?>'
    )">✏️</button>

    <button onclick="openDelete(<?= $r['id'] ?>)">🗑️</button>
</td>

</tr>
<?php endwhile; ?>

</table>

</div>
</div>
</div>

<!-- ================= ADD ================= -->
<div id="addModal" class="modal">
<div class="modal-content">

<h3>Añadir jugador</h3>

<form method="POST" enctype="multipart/form-data">

<input name="nombre" placeholder="Nombre">
<input name="edad" type="number" placeholder="Edad">
<input name="posicion" placeholder="Posición">
<input name="equipo" placeholder="Equipo">

<input name="rating" type="number" min="0" max="99" placeholder="Rating (0-99)">

<input type="file" name="foto">

<button name="add">Guardar</button>
</form>

<button onclick="closeModals()">Cerrar</button>

</div>
</div>

<!-- ================= EDIT ================= -->
<div id="editModal" class="modal">
<div class="modal-content">

<h3>Editar jugador</h3>

<form method="POST" enctype="multipart/form-data">

<input type="hidden" id="eid" name="id">

<input id="ename" name="nombre">
<input id="eage" name="edad">
<input id="epos" name="posicion">
<input id="eteam" name="equipo">

<input id="erating" name="rating" type="number" min="0" max="99">

<p>Cambiar imagen (opcional)</p>
<input type="file" name="foto">

<button name="update">Actualizar</button>
</form>

<button onclick="closeModals()">Cerrar</button>

</div>
</div>

<!-- ================= DELETE ================= -->
<div id="deleteModal" class="modal">
<div class="modal-content">

<h3>⚠️ Confirmar eliminación</h3>

<form method="POST">
    <input type="hidden" id="delete_id" name="delete_id">
    <button class="danger" type="submit">Sí, borrar</button>
</form>

<button onclick="closeModals()">Cancelar</button>

</div>
</div>

<script>

function openAdd(){
    document.getElementById("addModal").style.display="flex";
}

function openEdit(id,n,a,p,t,r){
    document.getElementById("editModal").style.display="flex";

    document.getElementById("eid").value=id;
    document.getElementById("ename").value=n;
    document.getElementById("eage").value=a;
    document.getElementById("epos").value=p;
    document.getElementById("eteam").value=t;
    document.getElementById("erating").value=r;
}

function openDelete(id){
    document.getElementById("deleteModal").style.display="flex";
    document.getElementById("delete_id").value=id;
}

function closeModals(){
    document.querySelectorAll(".modal").forEach(m=>{
        m.style.display="none";
    });
}

</script>

</body>
</html>