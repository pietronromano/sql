using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace PostgresEF.Data;


public partial class ComercioContext : DbContext
{
    string _connectionString;
    public ComercioContext(string connectionString)
    {
        _connectionString = connectionString;
    }

    public ComercioContext(DbContextOptions<ComercioContext> options)
        : base(options)
    {
        _connectionString = "";
    }

    public virtual DbSet<Categoria> Categorias { get; set; }

    public virtual DbSet<Cliente> Clientes { get; set; }

    public virtual DbSet<Pedido> Pedidos { get; set; }

    public virtual DbSet<PedidosProducto> PedidosProductos { get; set; }

    public virtual DbSet<Producto> Productos { get; set; }


    public virtual DbSet<VwClientesPedido> VwClientesPedidos { get; set; }

    public virtual DbSet<VwClientesProducto> VwClientesProductos { get; set; }

    /*
    Gets called the first time the Db is queried
    SEE: https://learn.microsoft.com/en-gb/ef/core/dbcontext-configuration/
    */
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder
            .UseNpgsql(this._connectionString)
            .EnableDetailedErrors() //More detailed query errors (at the expense of performance)
            .EnableSensitiveDataLogging() //Allows seeing IDs when debugging 
            .LogTo(Console.WriteLine, LogLevel.Trace);
    }
   
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {       
        modelBuilder.Entity<Categoria>(entity =>
        {
            entity.HasKey(e => e.IdCategoria).HasName("categorias_pkey");

            entity.ToTable("categorias", "comercio");

            entity.Property(e => e.IdCategoria)
                .ValueGeneratedNever()
                .HasColumnName("id_categoria");
            entity.Property(e => e.Categoria1)
                .HasMaxLength(50)
                .HasColumnName("categoria");
            entity.Property(e => e.Comentarios).HasColumnName("comentarios");
            entity.Property(e => e.IdPadre).HasColumnName("id_padre");

            entity.HasOne(d => d.IdPadreNavigation).WithMany(p => p.InverseIdPadreNavigation)
                .HasForeignKey(d => d.IdPadre)
                .HasConstraintName("fk_padre");
        });

        modelBuilder.Entity<Cliente>(entity =>
        {
            entity.HasKey(e => e.IdCliente).HasName("clientes_pkey");

            entity.ToTable("clientes", "comercio");

            entity.Property(e => e.IdCliente).HasColumnName("id_cliente");
            entity.Property(e => e.Activo)
                .HasDefaultValue(true)
                .HasColumnName("activo");
            entity.Property(e => e.Apellidos)
                .HasMaxLength(50)
                .HasColumnName("apellidos");
            entity.Property(e => e.Comentarios).HasColumnName("comentarios");
            entity.Property(e => e.FechaAlta)
                .HasDefaultValueSql("CURRENT_DATE")
                .HasColumnName("fecha_alta");
            entity.Property(e => e.Nif)
                .HasMaxLength(20)
                .HasColumnName("nif");
            entity.Property(e => e.Nombres)
                .HasMaxLength(50)
                .HasColumnName("nombres");
        });

        modelBuilder.Entity<Pedido>(entity =>
        {
            entity.HasKey(e => e.IdPedido).HasName("pedidos_pkey");

            entity.ToTable("pedidos", "comercio");

            entity.Property(e => e.IdPedido).HasColumnName("id_pedido");
            entity.Property(e => e.Comentarios).HasColumnName("comentarios");
            entity.Property(e => e.Fecha)
                .HasDefaultValueSql("CURRENT_DATE")
                .HasColumnName("fecha");
            entity.Property(e => e.IdCliente).HasColumnName("id_cliente");
            entity.Property(e => e.Pagado)
                .HasDefaultValue(false)
                .HasColumnName("pagado");

            entity.HasOne(d => d.IdClienteNavigation).WithMany(p => p.Pedidos)
                .HasForeignKey(d => d.IdCliente)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_cliente");
        });

        modelBuilder.Entity<PedidosProducto>(entity =>
        {
            entity.HasKey(e => new { e.IdPedido, e.IdProducto }).HasName("pedidos_productos_pkey");

            entity.ToTable("pedidos_productos", "comercio");

            entity.Property(e => e.IdPedido).HasColumnName("id_pedido");
            entity.Property(e => e.IdProducto).HasColumnName("id_producto");
            entity.Property(e => e.Cantidad).HasColumnName("cantidad");
            entity.Property(e => e.Comentarios).HasColumnName("comentarios");

            entity.HasOne(d => d.IdPedidoNavigation).WithMany(p => p.PedidosProductos)
                .HasForeignKey(d => d.IdPedido)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_pedido");

            entity.HasOne(d => d.IdProductoNavigation).WithMany(p => p.PedidosProductos)
                .HasForeignKey(d => d.IdProducto)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_producto");
        });

        modelBuilder.Entity<Producto>(entity =>
        {
            entity.HasKey(e => e.IdProducto).HasName("productos_pkey");

            entity.ToTable("productos", "comercio");

            entity.HasIndex(e => e.Nombre, "idx_productos_nombre");

            entity.Property(e => e.IdProducto)
                .HasDefaultValueSql("uuidv4()")
                .HasColumnName("id_producto");
            entity.Property(e => e.Activo)
                .HasDefaultValue(true)
                .HasColumnName("activo");
            entity.Property(e => e.Comentarios).HasColumnName("comentarios");
            entity.Property(e => e.Descripcion)
                .HasMaxLength(250)
                .HasColumnName("descripcion");
            entity.Property(e => e.FechaAlta).HasColumnName("fecha_alta");
            entity.Property(e => e.IdCategoria).HasColumnName("id_categoria");
            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .HasColumnName("nombre");
            entity.Property(e => e.Precio)
                .HasDefaultValue(9.99m)
                .HasColumnName("precio");

            entity.HasOne(d => d.IdCategoriaNavigation).WithMany(p => p.Productos)
                .HasForeignKey(d => d.IdCategoria)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_categoria");
        });

        modelBuilder.Entity<VwClientesPedido>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("vw_clientes_pedidos", "comercio");

            entity.Property(e => e.Apellidos)
                .HasMaxLength(50)
                .HasColumnName("apellidos");
            entity.Property(e => e.Fecha).HasColumnName("fecha");
            entity.Property(e => e.IdCliente).HasColumnName("id_cliente");
            entity.Property(e => e.Nombres)
                .HasMaxLength(50)
                .HasColumnName("nombres");
            entity.Property(e => e.Pagado).HasColumnName("pagado");
        });

        modelBuilder.Entity<VwClientesProducto>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("vw_clientes_productos", "comercio");

            entity.Property(e => e.IdCliente).HasColumnName("id_cliente");
            entity.Property(e => e.Producto)
                .HasMaxLength(50)
                .HasColumnName("producto");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
