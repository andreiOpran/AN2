﻿using ArticlesApp.Data;
using ArticlesApp.Models;
using Microsoft.AspNetCore.Mvc;

namespace ArticlesApp.Controllers
{
    public class CommentsController : Controller
    {
        private readonly ApplicationDbContext db;
        public CommentsController(ApplicationDbContext context)
        {
            db = context;
        }

        // adaugare comentariu asociat unui articol in baza de date
        [HttpPost]
        public IActionResult New(Comment comm)
        {
            comm.Date = DateTime.Now;

            try
            {
                db.Comments.Add(comm);
                db.SaveChanges();
                return Redirect("/Articles/Show/" + comm.ArticleId);
            }
            catch (Exception)
            {
                return Redirect("/Articles/Show/" + comm.ArticleId);
            }
        }

        // stergerea unui comentariu asociat unui articol din baza de date
        [HttpPost]
        public IActionResult Delete(int id)
        {
            Comment comm = db.Comments.Find(id);
            db.Comments.Remove(comm);
            db.SaveChanges();
            return Redirect("/Articles/Show/" + comm.ArticleId);
        }

        // implementarea editarii se va face intr-o pagina View separata
        // se editeaz un comentariu existent

        public IActionResult Edit(int id)
        {
            Comment comm = db.Comments.Find(id);
            ViewBag.Comment = comm;
            return View();
        }

        [HttpPost]
        public IActionResult Edit(int id, Comment requestComment)
        {
            Comment comm = db.Comments.Find(id);
            try
            {
                comm.Content = requestComment.Content;
                db.SaveChanges();
                return Redirect("/Articles/Show/" + comm.ArticleId);
            }
            catch (Exception)
            {
                return Redirect("/Articles/Show/" + comm.ArticleId);
            }
        }
    }
}
