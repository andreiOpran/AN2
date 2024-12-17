using System.ComponentModel.DataAnnotations;

namespace ExercitiuLaborator12.Models
{
    public class Gym
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Numele sălii de sport este obligatoriu.")]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "Numele sălii de sport trebuie să aibă între 3 și 100 de caractere.")]
        public string? Nume { get; set; }
    }
}
