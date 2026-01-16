# Examples for DotNet with EntityFramework Core 10
# COURSE EXAMPLE: 
    - https://www.udemy.com/course/entity-framework-core-a-full-tour/
    - https://github.com/trevoirwilliams/EntityFrameworkCoreFullTour
# 26-Oct-2025

# .Net 10 is required for EF 10: version 10.0.0-rc.2.25502.107
https://dotnet.microsoft.com/en-us/download/dotnet/10.0

# Check the .Net SDK versions
dotnet --info



# Get the .NET CLI tools
dotnet tool install --global dotnet-ef  --version 10.0.0-rc.2.25502.107
## Gave error:
# Tools directory '/Users/macbookpro/.dotnet/tools' is not currently on the PATH environment variable.
## If you are using zsh, you can add it to your profile by running the following command:
# cat << \EOF >> ~/.zprofile
# Add .NET Core SDK tools
# export PATH="$PATH:/Users/macbookpro/.dotnet/tools"
# EOF


dotnet new console -o PostgresEF
cd PostgresEF

## Install the latest Microsoft.EntityFrameworkCore.Design package.
dotnet add package Microsoft.EntityFrameworkCore.Design  --version 10.0.0-rc.2.25502.107

dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL --version 10.0.0-rc.2

# NET console applications created using the dotnet new command template or Visual Studio by default don't expose configuration capabilities. 
dotnet add package Microsoft.Extensions.Configuration --version 10.0.0-rc.2.25502.107;

dotnet add package Microsoft.Extensions.Hosting --version 10.0.0-rc.2.25502.107;

# Scaffolding (Reverse Engineering): https://learn.microsoft.com/en-gb/ef/core/managing-schemas/scaffolding/?tabs=dotnet-core-cli
## Set the DB, NOT the search_path (see --schema in next command)
connString="Host=localhost;Username=postgres;Password=12345;Database=postgres";

## Re-engineering Worked fine: note --schema
mkdir Data
cd Data
dotnet ef dbcontext scaffold $connString Npgsql.EntityFrameworkCore.PostgreSQL --schema=comercio
