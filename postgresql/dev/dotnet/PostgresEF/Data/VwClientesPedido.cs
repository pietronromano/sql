using System;
using System.Collections.Generic;

namespace PostgresEF.Data;

public partial class VwClientesPedido
{
    public int? IdCliente { get; set; }

    public string? Nombres { get; set; }

    public string? Apellidos { get; set; }

    public DateOnly? Fecha { get; set; }

    public bool? Pagado { get; set; }
}
