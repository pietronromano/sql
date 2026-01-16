using System;
using System.Collections.Generic;

namespace PostgresEF.Data;

public partial class Cliente
{
    public int IdCliente { get; set; }

    public string Nif { get; set; } = null!;

    public string Nombres { get; set; } = null!;

    public string Apellidos { get; set; } = null!;

    public DateOnly FechaAlta { get; set; }

    public bool? Activo { get; set; }

    public string? Comentarios { get; set; }

    public virtual ICollection<Pedido> Pedidos { get; set; } = new List<Pedido>();
}
