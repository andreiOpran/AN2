using ArticlesApp.Data;
using ArticlesApp.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace ArticlesApp.Controllers
{
    [Authorize]
    public class ArticlesController : Controller
    {

        // PASUL 10: useri si roluri

        //private readonly ApplicationDbContext db;
        //public ArticlesController(ApplicationDbContext context)
        //{
        //    db = context;
        //}


        private readonly ApplicationDbContext db;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        public ArticlesController(
        ApplicationDbContext context,
        UserManager<ApplicationUser> userManager,
        RoleManager<IdentityRole> roleManager
        )
        {
            db = context;
            _userManager = userManager;
            _roleManager = roleManager;
        }


        // Se afiseaza lista tuturor articolelor impreuna cu categoria 
        // din care fac parte
        // HttpGet implicit
        [Authorize(Roles = "User,Editor,Admin")]
        public IActionResult Index()
        {
            var articles = db.Articles.Include("Category");

            // ViewBag.OriceDenumireSugestiva
            ViewBag.Articles = articles;

            if (TempData.ContainsKey("message"))
            {
                ViewBag.Message = TempData["message"];
            }

            return View();
        }

        // Se afiseaza un singur articol in functie de id-ul sau 
        // impreuna cu categoria din care face parte
        // In plus sunt preluate si toate comentariile asociate unui articol
        // HttpGet implicit
        [Authorize(Roles = "User,Editor,Admin")]
        public IActionResult Show(int id)
        {
            Article article = db.Articles.Include("Category").Include("Comments")
                              .Where(art => art.Id == id)
                              .First();

            return View(article);
        }

        // Se afiseaza formularul in care se vor completa datele unui articol
        // impreuna cu selectarea categoriei din care face parte
        // HttpGet implicit
        [Authorize(Roles = "Editor,Admin")]
        public IActionResult New()
        {
          
            Article article = new Article();

            article.Categ = GetAllCategories();

            return View(article);
        }

        // Se adauga articolul in baza de date
        [HttpPost]
        [Authorize(Roles = "Editor,Admin")]
        public IActionResult New(Article article)
        {
            article.Date = DateTime.Now;
            article.Categ = GetAllCategories();

            if (!ModelState.IsValid)
            {            
                return View(article);
            }

            try
            {
                db.Articles.Add(article);
                db.SaveChanges();
                TempData["message"] = "Articolul a fost adaugat";

                ModelState.Clear(); // altfel nu ma lasa sa dau submit daca am facut priam data o greseala

                return RedirectToAction("Index");
            
            }
            catch (Exception)
            {
                return View(article);
            }
        }

        [HttpPost]
        //[Authorize(Roles = "Editor,Admin")]
        public IActionResult Show([FromForm] Comment comment)
        {
            comment.Date = DateTime.Now;
            if (ModelState.IsValid)
            {
                db.Comments.Add(comment);
                db.SaveChanges();
                return Redirect("/Articles/Show/" + comment.ArticleId);
            }
            else
            {
                Article art = db.Articles.Include("Category").Include("Comments")
                .Where(art => art.Id == comment.ArticleId).First();
                //return Redirect("/Articles/Show/" + comm.ArticleId);
                return View(art);
            }
        }


        // Se editeaza un articol existent in baza de date impreuna cu categoria din care face parte
        // Categoria se selecteaza dintr-un dropdown
        // HttpGet implicit
        // Se afiseaza formularul impreuna cu datele aferente articolului din baza de date
        [Authorize(Roles = "Editor,Admin")]
        public IActionResult Edit(int id)
        {

            Article article = db.Articles.Include("Category")
                                         .Where(art => art.Id == id)
                                         .First();

            article.Categ = GetAllCategories();

            return View(article);

        }

        // Se adauga articolul modificat in baza de date
        [HttpPost]
        [Authorize(Roles = "Editor,Admin")]
        public IActionResult Edit(int id, Article requestArticle)
        {
            Article article = db.Articles.Find(id);

            if(!ModelState.IsValid)
            {
                requestArticle.Categ = GetAllCategories();
                return View(requestArticle);
            }

            try
            {


                //if (string.IsNullOrEmpty(requestArticle.Title))
                //    ModelState.AddModelError(string.Empty, "Titlul trebuie completat");

                //if (!string.IsNullOrEmpty(requestArticle.Title) && requestArticle.Title.Length < 5)
                //    ModelState.AddModelError(string.Empty, "Titlul trebuie sa aiba minim 5 caractere");
                //if (!string.IsNullOrEmpty(requestArticle.Title) && requestArticle.Title.Length > 100)
                //    ModelState.AddModelError(string.Empty, "Titlul trebuie sa aiba maxim 100 de caractere");

                //if (string.IsNullOrEmpty(requestArticle.Content))
                //    ModelState.AddModelError(string.Empty, "Continutul articolului este obligatoriu");

                //if (requestArticle.CategoryId == null || requestArticle.CategoryId == 0)
                //    ModelState.AddModelError(string.Empty, "Categoria este obligatorie");

                //if (ModelState.IsValid == false)
                //    throw new Exception("Datele introduse nu sunt valide");


                article.Title = requestArticle.Title;
                article.Content = requestArticle.Content;
                article.Date = DateTime.Now;
                article.CategoryId = requestArticle.CategoryId;

                db.SaveChanges();
                TempData["message"] = "Articolul a fost modificat";
                return RedirectToAction("Index");

            }
            catch (Exception)
            {
                requestArticle.Categ = GetAllCategories();
                return View(requestArticle);
            }
        }


        // Se sterge un articol din baza de date 
        [HttpPost]
        [Authorize(Roles = "Editor,Admin")]
        public ActionResult Delete(int id)
        {

            // TODO: trebuie sterse comentariile inainte, altfel da eroare

            Article article = db.Articles.Find(id);
            db.Articles.Remove(article);
            db.SaveChanges();
            TempData["message"] = "Articolul a fost sters";
            return RedirectToAction("Index");
        }

        [NonAction]
        public IEnumerable<SelectListItem> GetAllCategories()
        {
            // generam o lista de tipul SelectListItem fara elemente
            var selectList = new List<SelectListItem>();

            // extragem toate categoriile din baza de date
            var categories = from cat in db.Categories
                             select cat;

            // iteram prin categorii
            foreach (var category in categories)
            {
                // adaugam in lista elementele necesare pentru dropdown
                // id-ul categoriei si denumirea acesteia
                selectList.Add(new SelectListItem
                {
                    Value = category.Id.ToString(),
                    Text = category.CategoryName
                });
            }
            /* Sau se poate implementa astfel: 
             * 
            foreach (var category in categories)
            {
                var listItem = new SelectListItem();
                listItem.Value = category.Id.ToString();
                listItem.Text = category.CategoryName;

                selectList.Add(listItem);
             }*/


            // returnam lista de categorii
            return selectList;
        }
    }
}
