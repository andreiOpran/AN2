﻿using ArticlesApp.Data;
using ArticlesApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ArticlesApp.Controllers
{
    public class ArticlesController : Controller
    {
        private readonly ApplicationDbContext db;
        public ArticlesController(ApplicationDbContext context)
        {
            db = context;
        }

        // Se afiseaza lista tuturor articolelor impreuna cu categoria 
        // din care fac parte
        // HttpGet implicit
        public IActionResult Index()
        {
            var articles = db.Articles.Include("Category");

            //SAU
            /*
            var articles = from article in db.Articles.Include("Category")
                           orderby article.Date descending
                           select article;
            
            */

            // ViewBag.OriceDenumireSugestiva
            ViewBag.Articles = articles;

            return View();
        }

        // Se afiseaza un singur articol in functie de id-ul sau 
        // impreuna cu categoria din care face parte
        // In plus sunt preluate si toate comentariile asociate unui articol
        // HttpGet implicit
        public IActionResult Show(int id)
        {   
            Article article = db.Articles.Include("Category").Include("Comments")
                               .Where(art => art.Id == id)
                               .First();
            

            /*
            Article article = (from art in db.Articles.Include("Category").Include("Comments")
                              where art.Id == id
                              select art).First();

            */


            ViewBag.Article = article;

            ViewBag.Category = article.Category;

            // ViewBag.Category(ViewBag.UnNume) = article.Category (proprietatea Category);
            return View();
        }


        // Se afiseaza formularul in care se vor completa datele unui articol
        // impreuna cu selectarea categoriei din care face parte
        // HttpGet implicit

        public IActionResult New()
        {
            var categories = from categ in db.Categories
                             select categ;

            ViewBag.Categories = categories;

            return View();
        }

        // Se adauga articolul in baza de date
        [HttpPost]
        public IActionResult New(Article article)
        {
            try
            {
                article.Date = DateTime.Now;
                db.Articles.Add(article);
                db.SaveChanges();
                  return RedirectToAction("Index");
                //  return Redirect("/Articles/Index"); 
            }

            catch (Exception)
            {
                return RedirectToAction("New");
            }
        }

        // Se editeaza un articol existent in baza de date impreuna cu categoria din care face parte
        // Categoria se selecteaza dintr-un dropdown
        // HttpGet implicit
        // Se afiseaza formularul impreuna cu datele aferente articolului din baza de date
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

        // Se adauga articolul modificat in baza de date
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

        // Se sterge un articol din baza de date 
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

