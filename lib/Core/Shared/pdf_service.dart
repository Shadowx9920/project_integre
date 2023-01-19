import 'dart:convert';
import 'dart:ui';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:universal_html/html.dart';

import '../Database/Controllers/etablissement_controller.dart';
import '../Database/Controllers/users_controller.dart';
import '../Database/Models/compte.dart';
import '../Database/Models/etablissement.dart';

class PdfServiceWeb {
  static Future<void> _saveAndLaunchFileWeb(
      List<int> bytes, String fileName) async {
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", fileName)
      ..click();
  }

  static Future<void> createPdfFileWeb() async {
    PdfDocument document = PdfDocument();

    final page = document.pages.add();

    page.graphics
        .drawString('Rapprt', PdfStandardFont(PdfFontFamily.helvetica, 30));

    //--------------------------------------------------------------------------------
    PdfGrid usersGrid = PdfGrid();
    usersGrid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 16),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    usersGrid.columns.add(count: 5);
    usersGrid.headers.add(1);

    PdfGridRow header = usersGrid.headers[0];
    header.cells[0].value = 'Name';
    header.cells[1].value = 'Id';
    header.cells[2].value = 'Email';
    header.cells[3].value = 'Password';
    header.cells[4].value = 'Account Type';

    List<Compte> users = await UsersController.getAllAcountsFuture();

    for (int i = 0; i < users.length; i++) {
      PdfGridRow row = usersGrid.rows.add();
      row.cells[0].value = users[i].name;
      row.cells[1].value = users[i].id;
      row.cells[2].value = users[i].email;
      row.cells[3].value = users[i].password;
      row.cells[4].value = (users[i].accType == 0)
          ? 'Admin'
          : (users[i].accType == 1)
              ? 'Responsable'
              : (users[i].accType == 1)
                  ? 'Professeur'
                  : 'Etudiant';
    }

    usersGrid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    //--------------------------------------------------------------------------------
    PdfGrid etablissementsGrid = PdfGrid();
    etablissementsGrid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 16),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    etablissementsGrid.columns.add(count: 4);
    etablissementsGrid.headers.add(1);

    PdfGridRow header2 = etablissementsGrid.headers[0];
    header2.cells[0].value = 'Name';
    header2.cells[1].value = 'Id';
    header2.cells[2].value = 'Email';
    header2.cells[3].value = 'Responsable';

    List<Etablissement> etablissements =
        await EtablissementController.getAllEtablissementFuture();

    for (int i = 0; i < etablissements.length; i++) {
      PdfGridRow row = etablissementsGrid.rows.add();
      row.cells[0].value = etablissements[i].name;
      row.cells[1].value = etablissements[i].uid;
      row.cells[2].value = etablissements[i].email;
      await UsersController.getAccount(etablissements[i].idResponsable)
          .then((value) => row.cells[3].value = value?.name ?? 'null');
    }

    etablissementsGrid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    //--------------------------------------------------------------------------------
    PdfGrid reunionsGrid = PdfGrid();
    reunionsGrid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 16),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    reunionsGrid.columns.add(count: 5);
    reunionsGrid.headers.add(1);

    PdfGridRow header3 = reunionsGrid.headers[0];
    header3.cells[0].value = 'Name';
    header3.cells[1].value = 'Id';
    header3.cells[2].value = 'Date';
    header3.cells[3].value = 'Etablissement';
    header3.cells[4].value = 'Responsable';

    List<int> bytes = await document.save();
    document.dispose();

    PdfServiceWeb._saveAndLaunchFileWeb(bytes, "Output.pdf");
  }
}
