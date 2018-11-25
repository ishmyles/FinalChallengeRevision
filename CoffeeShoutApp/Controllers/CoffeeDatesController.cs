using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using CoffeeShoutApp.Models;

namespace CoffeeShoutApp.Controllers
{
    public class CoffeeDatesController : Controller
    {
        private CoffeeShoutDBEntities db = new CoffeeShoutDBEntities();
        CoffeeDatesViewModels TotalShout = new CoffeeDatesViewModels();

        // GET: CoffeeDates
        public async Task<ActionResult> Index()
        {
            var coffeeDates = db.CoffeeDates.Include(c => c.Member);
            return View(await coffeeDates.ToListAsync());
        }

        //GET: PastCoffeeDates
        public async Task<ActionResult> PastCoffeeDates()
        {
            var coffeeDates = db.CoffeeDates.Include(c => c.Member);
            return View(await coffeeDates.ToListAsync());
        }

        //GET: TotalShouts
        public ActionResult TotalShouts()
        {
            TotalShout.Members = db.Members.ToList();
            TotalShout.CoffeeDates = db.CoffeeDates.Where(a => a.IsPending == 0).Include(c => c.Member).ToList();
            return View(TotalShout);
        }

        // GET: CoffeeDates/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CoffeeDate coffeeDate = await db.CoffeeDates.FindAsync(id);
            if (coffeeDate == null)
            {
                return HttpNotFound();
            }
            return View(coffeeDate);
        }

        // GET: CoffeeDates/Create
        public ActionResult Create()
        {
            ViewBag.ShoutedBy = new SelectList(db.Members, "ID", "FirstName");
            return View();
        }

        // POST: CoffeeDates/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "CoffeeDateNo,Date,Time,Venue,ShoutedBy,ShoutedAmount,IsPending")] CoffeeDate coffeeDate)
        {
            if (ModelState.IsValid)
            {
                db.CoffeeDates.Add(coffeeDate);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            ViewBag.ShoutedBy = new SelectList(db.Members, "ID", "FirstName", coffeeDate.ShoutedBy);
            return View(coffeeDate);
        }

        // GET: CoffeeDates/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CoffeeDate coffeeDate = await db.CoffeeDates.FindAsync(id);
            if (coffeeDate == null)
            {
                return HttpNotFound();
            }
            ViewBag.ShoutedBy = new SelectList(db.Members, "ID", "FirstName", coffeeDate.ShoutedBy);
            return View(coffeeDate);
        }

        // POST: CoffeeDates/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "CoffeeDateNo,Date,Time,Venue,ShoutedBy,ShoutedAmount,IsPending")] CoffeeDate coffeeDate)
        {
            if (ModelState.IsValid)
            {
                db.Entry(coffeeDate).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.ShoutedBy = new SelectList(db.Members, "ID", "FirstName", coffeeDate.ShoutedBy);
            return View(coffeeDate);
        }

        // GET: CoffeeDates/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CoffeeDate coffeeDate = await db.CoffeeDates.FindAsync(id);
            if (coffeeDate == null)
            {
                return HttpNotFound();
            }
            return View(coffeeDate);
        }

        // POST: CoffeeDates/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            CoffeeDate coffeeDate = await db.CoffeeDates.FindAsync(id);
            db.CoffeeDates.Remove(coffeeDate);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
