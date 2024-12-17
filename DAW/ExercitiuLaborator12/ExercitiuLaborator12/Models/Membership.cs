using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ExercitiuLaborator12.Models
{
    public class Membership
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Titlul abonamentului este obligatoriu.")]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "Titlul abonamentului trebuie să aibă între 3 și 100 de caractere.")]
        public string? Title { get; set; }

        [Required(ErrorMessage = "Valoarea abonamentului este obligatorie.")]
        [Range(1, int.MaxValue, ErrorMessage = "Valoarea abonamentului trebuie să fie un număr pozitiv.")]
        public int? Valoare { get; set; }

        [Required(ErrorMessage = "Data emiterii abonamentului este obligatorie.")]
        public DateTime? DataEmitere { get; set; }

        [Required(ErrorMessage = "GymId este obligatoriu.")]
        public int? GymId { get; set; }

        [Required(ErrorMessage = "Gym este obligatoriu.")]
        public virtual Gym? Gym { get; set; }

        [NotMapped]
        public IEnumerable<SelectListItem>? Gyms { get; set; }
    }
}
