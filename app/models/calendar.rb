#encoding: utf-8
class Calendar
  def self.schedule(date)
    school_begins = (date + (date.month > 6 ?  7.years : 6.years))
      .beginning_of_year.months_since(1)
    [
      [date + 0.days, ['B.C.G.', 'Hepatitis B'], 'Recién nacido'],
      [date + 2.months, [
        'Vacuna Sextuple. Incluye: Hepatitis B, Sabin o Salk (OPV o IPV) y Cuádruple (DTP + Hib)',
        'Neumococo Conjugada'], '2 meses'],
      [date + 4.months, [
        'Vacuna Sextuple. Incluye: Hepatitis B, Sabin o Salk (OPV o IPV) y Cuádruple (DTP + Hib)',
        'Neumococo Conjugada'], '4 meses'],
      [date + 6.months, [
        'Vacuna Sextuple. Incluye: Hepatitis B, Sabin o Salk (OPV o IPV) y Cuádruple (DTP + Hib)',
        'Antigripal'], '6 meses'],
      [date + 12.months, [
        'Vacuna Sextuple. Incluye: Hepatitis B, Sabin o Salk (OPV o IPV) y Cuádruple (DTP + Hib)',
        'Antigripal',
        'Neumococo Conjugada',
        'Triple Viral (SRP)',
        'Hepatitis A'], '12 meses'],
      [date + 18.months, [
        'Antigripal',
        'Refuerzo Sabin o Salk',
        'Refuerzo Cuádruple',
        'Hepatitis A'], '18 meses'],
      [date + 24.months, [ 'Antigripal' ], '24 meses'],
      [school_begins, [
        'Refuerzo Sabin o Salk',
        'Refuerzo Triple Viral (SRP)',
        'Refuerzo Triple Bacteriana (DTP)'], 'Ingreso Escolar'],
      [date + 11.years, [
        'VPH (solo niñas, 3 dosis)',
        'Refuerzo Triple Bacteriana Adultos acelular (dTpa)'], '11 años'],
      [date + 16.years, ['Refuerzo Doble Bacteriana Adultos (dT)'], '16 años']
    ]
  end

  def self.generate_ics(name, birthdate)
    RiCal.Calendar do |calendar|
      schedule(birthdate).each do |date, vaccines|
        vaccines.each do |vaccine|
          calendar.todo do |todo|
            todo.summary "Vacunar a #{name}"
            todo.description "Vacunar a #{name}: #{vaccine}"
            todo.dtstart date
            todo.due date + 7.days
          end
          calendar.event do |todo|
            todo.summary "Vacunar a #{name}"
            todo.description "Vacunar a #{name}: #{vaccine}"
            todo.dtstart date
          end
        end
      end
    end
  end
end
