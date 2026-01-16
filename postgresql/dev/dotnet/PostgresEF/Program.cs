using PostgresEF.Data;

//namespace PostgresEF; CAN'T USE IF NOT USING CLASS Structure

using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;


//Config: SEE: https://learn.microsoft.com/en-us/dotnet/core/extensions/configuration-providers
HostApplicationBuilder builder = Host.CreateApplicationBuilder(args);
builder.Configuration.Sources.Clear();

IHostEnvironment env = builder.Environment;
builder.Configuration
    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
using IHost host = builder.Build();

// Application code should start here.
string? connectionString = builder.Configuration.GetSection("ConnectionString").Value;
#pragma warning disable CS8604 // Possible null reference argument.
using var db = new ComercioContext(connectionString);
#pragma warning restore CS8604 // Possible null reference argument.


// Note: This sample requires the database to be created before running.
//Console.WriteLine($"Database path: {db.Database.}.");

// Read
Console.WriteLine("Querying for a Cliente");
var cliente = await db.Clientes
    .OrderBy(b => b.IdCliente)
    .FirstAsync();

Console.WriteLine("Nif: " + cliente.Nif);

// Crear un nuevo Cliente
Console.WriteLine("Inserting a new Cliente");
var newCliente = new Cliente {
    Nif = "NNNNNNNN1",
    Nombres = "Nombres 20",
    Apellidos = "Apellidos 20",
    FechaAlta = new DateOnly(2025, 1, 1),
    Activo = true,
    Comentarios = "Comentarios 20"
};
db.Add(newCliente);
await db.SaveChangesAsync();

//SEE: https://learn.microsoft.com/en-gb/ef/core/change-tracking/debug-views
Console.WriteLine(db.ChangeTracker.DebugView.LongView);

//Obtener todos los productos: SEE https://learn.microsoft.com/en-gb/ef/core/querying/
await db.Productos.ToListAsync();
Producto producto1 = db.Productos.First();

// Update
Pedido newPedido = new Pedido
{
    Fecha = DateOnly.FromDateTime(DateTime.Now),
    Comentarios = "Pedido añadido desde .Net",
    Pagado = true
};
newPedido.PedidosProductos.Add(
    new PedidosProducto
    {
        IdProducto = producto1.IdProducto,
        Cantidad = 10,
        Comentarios = "10 de " + producto1.IdProducto
    }
);
newCliente.Pedidos.Add(newPedido);
await db.SaveChangesAsync();

// Delete: NO funcionará porqué pedidos_productos tiene un registro relacionado
try
{
    Console.WriteLine("Suprimir el Pedido");
    db.Remove(newPedido);
    await db.SaveChangesAsync();
    Console.WriteLine(db.ChangeTracker.DebugView.LongView);
}
catch (System.Exception exc)
{
    Console.WriteLine(exc.StackTrace);
}

