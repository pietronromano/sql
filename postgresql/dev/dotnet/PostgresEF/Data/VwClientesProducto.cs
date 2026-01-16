using System;
using System.Collections.Generic;

namespace PostgresEF.Data;

public partial class VwClientesProducto
{
    public int? IdCliente { get; set; }

    public string? Producto { get; set; }
}
