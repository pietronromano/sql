using System;
using System.Collections.Generic;

namespace PostgresEF.Data;

public partial class Categoria
{
    public int IdCategoria { get; set; }

    public string Categoria1 { get; set; } = null!;

    public int? IdPadre { get; set; }

    public string? Comentarios { get; set; }

    public virtual Categoria? IdPadreNavigation { get; set; }

    public virtual ICollection<Categoria> InverseIdPadreNavigation { get; set; } = new List<Categoria>();

    public virtual ICollection<Producto> Productos { get; set; } = new List<Producto>();
}
