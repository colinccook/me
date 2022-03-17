dotnet tool install dotnet-ef -g

dotnet ef migrations script (from) (to)
dotnet ef database update --project Persistence
dotnet ef migrations remove --project Persistence
dotnet ef migrations add "colin_cook_added_this" --project Persistence




