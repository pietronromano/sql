using System;
using System.Collections.Generic;

namespace PostgresEF.Data;

public partial class Producto
{
    public Guid IdProducto { get; set; }

    public string Nombre { get; set; } = null!;

    public string Descripcion { get; set; } = null!;

    public int IdCategoria { get; set; }

    public DateOnly FechaAlta { get; set; }

    public bool? Activo { get; set; }

    public decimal Precio { get; set; }

    public string? Comentarios { get; set; }

    public virtual Categoria IdCategoriaNavigation { get; set; } = null!;

    public virtual ICollection<PedidosProducto> PedidosProductos { get; set; } = new List<PedidosProducto>();
}
