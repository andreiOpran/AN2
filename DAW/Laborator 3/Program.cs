using Laborator_3.Controllers;
using System.Security.Cryptography;

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

// Exercitiul 1

/* 
    ExamplesController/Concatenare/s1/s2
*/

/*

app.MapControllerRoute(
    name: "Concatenare", // poate fi si "concat" 
    pattern: "concatenare/{controller=Examples}/{action=Concatenare}/{s1}/{s2}" // s1 si s2 trebuie sa fie la fel cu numele parametrilor din metoda Concatenare
    );

// https://localhost:7034/Concatenare/Examples/Concatenare/abc/xyz

*/

// https://localhost:7034/concatenare/abc/xyz
app.MapControllerRoute(
       name: "Concatenare",
       pattern: "concatenare/{s1}/{s2}", // s1 si s2 trebuie sa fie la fel cu numele parametrilor din metoda Concatenare
       defaults: new { controller = "Examples", action = "Concatenare" }
       );

// https://localhost:7034/produs/5/7
app.MapControllerRoute(
       name: "Produs",
       pattern: "produs/{param1}/{param2?}",
       defaults: new { controller = "Examples", action = "Produs" }
       );

app.MapControllerRoute(
    name: "Operatie",
    pattern: "operatie/{a?}/{b?}/{op?}",
    defaults: new { controller = "Examples", action = "Operatie" }
    );



// Exercitiul 2

// https://localhost:7034/Student/all
app.MapControllerRoute(
       name: "StudentAll",
          pattern: "student/all",
             defaults: new { controller = "Student", action = "Index" }
                );

app.MapControllerRoute(
    name: "StudentNew",
    pattern: "student/new",
   defaults: new { controller = "Student", action = "Create" }
   );

// samd


app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");


app.Run();
