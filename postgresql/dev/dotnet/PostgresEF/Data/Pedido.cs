using System;
using System.Collections.Generic;

namespace PostgresEF.Data;

public partial class Pedido
{
    public int IdPedido { get; set; }

    public int IdCliente { get; set; }

    public DateOnly Fecha { get; set; }

    public bool? Pagado { get; set; }

    public string? Comentarios { get; set; }

    public virtual Cliente IdClienteNavigation { get; set; } = null!;

    public virtual ICollection<PedidosProducto> PedidosProductos { get; set; } = new List<PedidosProducto>();
}
