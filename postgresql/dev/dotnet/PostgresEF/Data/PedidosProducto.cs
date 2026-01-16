using System;
using System.Collections.Generic;

namespace PostgresEF.Data;

public partial class PedidosProducto
{
    public int IdPedido { get; set; }

    public Guid IdProducto { get; set; }

    public int Cantidad { get; set; }

    public string? Comentarios { get; set; }

    public virtual Pedido IdPedidoNavigation { get; set; } = null!;

    public virtual Producto IdProductoNavigation { get; set; } = null!;
}
