﻿using Laborator_5._2.Models;
using Microsoft.AspNetCore.Mvc;

namespace Laborator_5._2.Controllers
{
    public class ArticlesController : Controller
    {
        private readonly AppDbContext _db;

        public ArticlesController(AppDbContext context)
        {
            _db = context;
        }

        public IActionResult Index()
        {
            var articles = from article in _db.Articles
                            select article;

            ViewBag.Articles = articles;

           
            return View();
        }
        

        public ActionResult Show(int id)
        {
            Article? article = _db.Articles.Find(id);

            ViewBag.Article = article;

            return View();
        }

        public IActionResult New()
        {
            return View();
        }

        [HttpPost]
        public IActionResult New(Article article)
        {
            article.Date = System.DateTime.Now;
            
            try
            {
                _db.Articles.Add(article);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                return View();
            }
        }

        public IActionResult Edit(int id)
        {
            Article? article = _db.Articles.Find(id);

            ViewBag.Article = article;

            return View();
        }

        [HttpPost]
        public ActionResult Edit(int id, Article requestArticle)
        {
            Article? article = _db.Articles.Find(id);

            try
            {
                article.Title = requestArticle.Title;
                article.Content = requestArticle.Content;
                article.Date = requestArticle.Date;

                _db.SaveChanges();

                return RedirectToAction("Index");
            }
            catch(Exception)
            {
                return RedirectToAction("Edit", article.Id);
            }
        }

        [HttpPost]
        public ActionResult Delete(int id)
        {
            Article? article = _db.Articles.Find(id);

            if(article != null)
            {
                _db.Articles.Remove(article);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            else
            {
                return StatusCode(StatusCodes.Status404NotFound);
            }
        }
    }
}
