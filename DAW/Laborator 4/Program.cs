var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();


// articole/show/{id}
app.MapControllerRoute(
    name: "ArticlesShow", // numele ajuta la redirect (RedirectToRoute)
    pattern: "articole/show/{id}",
    defaults: new { controller = "Articles", action = "Show"}
    );


// ruta default trebuie sa fie ultima din cauza cascade-ului
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Articles}/{action=Index}/{id?}");

app.Run();
