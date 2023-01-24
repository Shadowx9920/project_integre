import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:universal_html/html.dart';

import '../Database/Controllers/etablissement_controller.dart';
import '../Database/Controllers/reunion_controller.dart';
import '../Database/Controllers/users_controller.dart';
import '../Database/Models/compte.dart';
import '../Database/Models/etablissement.dart';
import '../Database/Models/reunion.dart';

class PdfServiceWeb {
  static Future<void> _saveAndLaunchFileWeb(
      List<int> bytes, String fileName) async {
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", fileName)
      ..click();
  }

  static Future<List<int>> _readImageData(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  static Future<void> createPdfFileWeb() async {
    PdfDocument document = PdfDocument();

    final page = document.pages.add();

    double pageWidth = page.getClientSize().width;
    double pageHeight = page.getClientSize().height;

    //Center an Image in PDF and make it 4 times smaller
    final image = PdfBitmap(await _readImageData('assets/images/logo-UIR.png'));
    page.graphics.drawImage(
        image,
        Rect.fromLTWH(pageWidth / 2 - image.width / 8, 0, image.width / 4,
            image.height / 4));

    //Add a title "Rapport" to the center of the page with a line under it
    PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 20);
    PdfStringFormat format = PdfStringFormat();
    format.alignment = PdfTextAlignment.center;
    page.graphics.drawString('Rapport', font,
        bounds: Rect.fromLTWH(0, pageHeight / 2, pageWidth, 50),
        format: format);

    //add the current date to the page at the bottom right corner
    font = PdfStandardFont(PdfFontFamily.helvetica, 12);
    format = PdfStringFormat();
    format.alignment = PdfTextAlignment.right;
    page.graphics.drawString(DateTime.now().toString(), font,
        bounds: Rect.fromLTWH(0, pageHeight - 50, pageWidth, 50),
        format: format);
    //--------------------------------------------------------------------------------
    List<Compte> users = await UsersController.getAllAcountsFuture();
    List<Etablissement> etablissements =
        await EtablissementController.getAllEtablissementFuture();
    List<Reunion> reunions = await ReunionController.getReunionFuture();

    //add a page that contains the number of users in the database
    //and the number of etablissements and the number of reunions
    page.graphics.drawString('Nombre d\'utilisateurs: ${users.length}', font,
        bounds: Rect.fromLTWH(0, 0, pageWidth, 50), format: format);
    page.graphics.drawString(
        'Nombre d\'etablissements: ${etablissements.length}', font,
        bounds: Rect.fromLTWH(0, 50, pageWidth, 50), format: format);
    page.graphics.drawString('Nombre de reunions: ${reunions.length}', font,
        bounds: Rect.fromLTWH(0, 100, pageWidth, 50), format: format);

    //--------------------------------------------------------------------------------
    PdfGrid usersGrid = PdfGrid();
    usersGrid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    usersGrid.columns.add(count: 5);
    usersGrid.headers.add(1);

    PdfGridRow header = usersGrid.headers[0];
    header.cells[0].value = 'Name';
    header.cells[0].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));
    header.cells[1].value = 'Id';
    header.cells[1].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));
    header.cells[2].value = 'Email';
    header.cells[2].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));
    header.cells[3].value = 'Password';
    header.cells[3].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));
    header.cells[4].value = 'Account Type';
    header.cells[4].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));

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
              : (users[i].accType == 2)
                  ? 'Professeur'
                  : 'Etudiant';
    }

    usersGrid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    //--------------------------------------------------------------------------------
    PdfGrid etablissementsGrid = PdfGrid();
    etablissementsGrid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    etablissementsGrid.columns.add(count: 4);
    etablissementsGrid.headers.add(1);

    PdfGridRow header2 = etablissementsGrid.headers[0];
    header2.cells[0].value = 'Name';
    header2.cells[0].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));
    header2.cells[1].value = 'Id';
    header2.cells[1].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));
    header2.cells[2].value = 'Email';
    header2.cells[2].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));
    header2.cells[3].value = 'Responsable';
    header2.cells[3].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));

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
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    reunionsGrid.columns.add(count: 5);
    reunionsGrid.headers.add(1);

    PdfGridRow header3 = reunionsGrid.headers[0];
    header3.cells[0].value = 'Subject';
    header3.cells[0].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));
    header3.cells[1].value = 'Id';
    header3.cells[1].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));
    header3.cells[2].value = 'Date';
    header3.cells[2].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));
    header3.cells[3].value = 'Etablissement';
    header3.cells[3].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));
    header3.cells[4].value = 'Responsable';
    header3.cells[4].style = PdfGridCellStyle(
        backgroundBrush: PdfSolidBrush(PdfColor(0, 0, 0)),
        textBrush: PdfSolidBrush(PdfColor(255, 255, 255)));

    for (int i = 0; i < reunions.length; i++) {
      PdfGridRow row = reunionsGrid.rows.add();
      row.cells[0].value = reunions[i].subject;
      row.cells[1].value = reunions[i].uid;
      row.cells[2].value = reunions[i].date;
      await EtablissementController.getEtablissement(
              reunions[i].idEtablissement)
          .then((value) => row.cells[3].value = value?.name ?? 'null');
      await UsersController.getAccount(reunions[i].profId)
          .then((value) => row.cells[4].value = value?.name ?? 'null');
    }

    reunionsGrid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    List<int> bytes = await document.save();
    document.dispose();

    PdfServiceWeb._saveAndLaunchFileWeb(bytes, "Output.pdf");
  }
}
