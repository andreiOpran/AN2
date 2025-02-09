using System.ComponentModel.DataAnnotations;

namespace Laborator_5._2.Models
{
    public class Category
    {
        [Key]
        public int Id { get; set; }
        public string CategoryName { get; set; }
    }
}
