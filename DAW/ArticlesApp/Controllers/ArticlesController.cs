using ArticlesApp.Data;
using ArticlesApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ArticlesApp.Controllers
{
    public class ArticlesController : Controller
    {

        private readonly ApplicationDbContext db; // readonly pt ca este o referinta
        public ArticlesController(ApplicationDbContext context)
        {
            db = context;
        }

        // get implicit
        public IActionResult Index()
        {
            var articles = db.Articles.Include("Category"); // include face join cu tabelele asociate; lambda expression

            // sau varianta 2
            var articles2 = from article in db.Articles.Include("Category")
                           orderby article.Date descending
                           select article;

            // ViewBag.OriceDenumireSugestiva
            ViewBag.Articles = articles;
            // ViewBag.Articles = articles2;
            
            return View();
        }

        // se afiseaza un anumit articol impreuna cu categoria si comentariile\
        // get implicit
        public IActionResult Show(int id)
        {
            Article article = db.Articles.Include("Category").Include("Comments")
                                .Where(art => art.Id == id)
                                .First();

            // sau varianta 2
            Article article2 = (from art in db.Articles.Include("Category").Include("Comments")
                                where art.Id == id
                                select art).First();

            ViewBag.Article = article;
            ViewBag.Category = article.Category;

            // Viewbag.Category(Viewbag.UnNume) = article.Category;

            return View();
        }


        // afisam formularul si selectam categoria
        // get implicit
        public IActionResult New()
        {
            var categories = from categ in db.Categories
                             select categ;

            ViewBag.Categories = categories;

            return View();
        }
        // adaugare in baza de date
        [HttpPost]
        public IActionResult New(Article article)
        {
            try
            {
                article.Date = DateTime.Now;
                db.Articles.Add(article);
                db.SaveChanges();
                return RedirectToAction("Index");
                // return Redirect("/Articles/Index");
            }
            catch (Exception)
            {
                return View();
            }
        }

        // editarea unui articol existent
        // se selcteaza categoria dintr-un dropdown
        // get implicit
        // se afiseaza formularul cu datele articolului
        public IActionResult Edit(int id)
        {
            Article article = db.Articles.Include("Category")
                                         .Where(art => art.Id == id)
                                         .First();

            ViewBag.Article = article;
            ViewBag.Category = article.Category;

            var categories = from categ in db.Categories
                             select categ;

            ViewBag.Categories = categories;

            return View();
        }
        // adaugare in baza de date a articolului editat
        [HttpPost]
        public IActionResult Edit(int id, Article requestArticle)
        {
            Article article = db.Articles.Find(id);

            try
            {

                article.Title = requestArticle.Title;
                article.Content = requestArticle.Content;
                article.CategoryId = requestArticle.CategoryId;
                db.SaveChanges();


                return RedirectToAction("Index");
            }

            catch (Exception)
            {
                return RedirectToAction("Edit", id);

            }
        }

        // stergerea unui articol din baza de date
        [HttpPost]
        public ActionResult Delete(int id)
        {
            Article article = db.Articles.Find(id);
            db.Articles.Remove(article);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
