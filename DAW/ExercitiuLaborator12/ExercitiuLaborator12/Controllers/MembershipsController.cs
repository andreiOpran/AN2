using ExercitiuLaborator12.Data;
using ExercitiuLaborator12.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace ExercitiuLaborator12.Controllers
{
    public class MembershipsController : Controller
    {
        public readonly ApplicationDbContext db;

        public MembershipsController(ApplicationDbContext context)
        {
            db = context;
        }

        public IActionResult Index()
        {
            var memberships = db.Memberships.Include(m => m.Gym)
                                            .OrderByDescending(m => m.DataEmitere)
                                            .ToList();

            ViewBag.Memberships = memberships;

            return View();
        }

        public IActionResult New()
        {
            Membership membership = new Membership();
            membership.Gyms = GetAllGyms();
            return View(membership);
        }

        [HttpPost]
        public IActionResult New(Membership membership)
        {
            membership.DataEmitere = DateTime.Now;
            membership.Gyms = GetAllGyms();

            // probleme la validare (selectare Gym)
            //if (!ModelState.IsValid)
            //{
            //    return View(membership);
            //}

            try
            {
                var gym = db.Gyms.Find(membership.GymId);
                if (gym == null)
                {
                    ModelState.AddModelError("GymId", "Gym not found.");
                    membership.Gyms = GetAllGyms();
                    return View(membership);
                }

                membership.Gym = gym;
                db.Memberships.Add(membership);
                db.SaveChanges();

                TempData["message"] = "Abonamentul a fost adaugat cu succes.";
                TempData["messageType"] = "alert-success";

                ModelState.Clear();

                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                return View(membership);
            }
        }

        public ActionResult Edit(int id)
        {
            Membership membership = db.Memberships.Find(id);
            membership.Gyms = GetAllGyms();
            return View(membership);
        }

        [HttpPost]
        public ActionResult Edit(int id, Membership requestMembership)
        {
            Membership membership = db.Memberships.Find(id);

            // probleme la validare (selectare Gym)
            //if (ModelState.IsValid)
            //{
            var gym = db.Gyms.Find(requestMembership.GymId);
                if (gym == null)
                {
                    ModelState.AddModelError("GymId", "Gym not found.");
                    requestMembership.Gyms = GetAllGyms();
                    return View(requestMembership);
                }

                membership.Title = requestMembership.Title;
                membership.Valoare = requestMembership.Valoare;
                membership.GymId = requestMembership.GymId;
                membership.Gym = gym;

                db.SaveChanges();
                TempData["message"] = "Abonamentul a fost modificat cu succes.";
                TempData["messageType"] = "alert-success";
                return RedirectToAction("Index");
            //}
            //else
            //{
            //    requestMembership.Gyms = GetAllGyms();
            //    return View(requestMembership);
            //}
        }

        [HttpPost]
        public ActionResult Delete(int id)
        {
            Membership membership = db.Memberships.Find(id);
            db.Memberships.Remove(membership);
            db.SaveChanges();
            TempData["message"] = "Abonamentul a fost sters cu succes.";
            TempData["messageType"] = "alert-success";
            return RedirectToAction("Index");
        }

        [NonAction]
        public IEnumerable<SelectListItem> GetAllGyms()
        {
            var selectList = new List<SelectListItem>();

            var gyms = from gym in db.Gyms
                       select gym;

            foreach (var gym in gyms)
            {
                selectList.Add(new SelectListItem
                {
                    Value = gym.Id.ToString(),
                    Text = gym.Nume
                });
            }

            return selectList;
        }
    }
}
