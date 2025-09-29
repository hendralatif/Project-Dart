Map<String, double> hitungPajak(double gajiBulanan) {
  // PTKP tahunan (TK/0)
  const double PTKP = 54000000;

  // Hitung penghasilan kena pajak tahunan
  double pkpTahunan = (gajiBulanan * 12) - PTKP;

  if (pkpTahunan <= 0) {
    return {
      "pajakTahunan": 0,
      "pajakBulanan": 0,
    };
  }

  double pajakTahunan = 0;
  double sisa = pkpTahunan;

  // Lapisan 1: 0 – 60.000.000 (5%)
  double lapisan1 = 60000000;
  if (sisa > 0) {
    double kena = sisa > lapisan1 ? lapisan1 : sisa;
    pajakTahunan += kena * 0.05;
    sisa -= kena;
  }

  // Lapisan 2: 60.000.001 – 250.000.000 (15%)
  double lapisan2 = 250000000 - 60000000;
  if (sisa > 0) {
    double kena = sisa > lapisan2 ? lapisan2 : sisa;
    pajakTahunan += kena * 0.15;
    sisa -= kena;
  }

  // Lapisan 3: 250.000.001 – 500.000.000 (25%)
  double lapisan3 = 500000000 - 250000000;
  if (sisa > 0) {
    double kena = sisa > lapisan3 ? lapisan3 : sisa;
    pajakTahunan += kena * 0.25;
    sisa -= kena;
  }

  // Lapisan 4: 500.000.001 – 5.000.000.000 (30%)
  double lapisan4 = 5000000000 - 500000000;
  if (sisa > 0) {
    double kena = sisa > lapisan4 ? lapisan4 : sisa;
    pajakTahunan += kena * 0.30;
    sisa -= kena;
  }

  // Lapisan 5: > 5.000.000.000 (35%)
  if (sisa > 0) {
    pajakTahunan += sisa * 0.35;
  }

  return {
    "pajakTahunan": pajakTahunan,
    "pajakBulanan": pajakTahunan / 12,
  };
}

void main() {
  double gaji = 10000000; // contoh gaji bulanan Rp10.000.000
  var hasil = hitungPajak(gaji);

  print("Gaji Bulanan : Rp${gaji.toStringAsFixed(0)}");
  print("Pajak Tahunan: Rp${hasil["pajakTahunan"]!.toStringAsFixed(0)}");
  print("Pajak Bulanan: Rp${hasil["pajakBulanan"]!.toStringAsFixed(0)}");
}
