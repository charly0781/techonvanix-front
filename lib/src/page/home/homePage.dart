import 'package:flutter/material.dart';
import '../../dto/library/ApiResponse.dart';
import '../../dto/library/GlobalData.dart';
import '../../service/Utilitarios.dart';
import '../transversal/MessageDialog.dart';
import 'FloatingMenu.dart';
import 'HeaderHomePage.dart';
import 'MenuBarHeader.dart';
import 'FooterHomePage.dart';
import 'content/Content.dart';
import 'content/Empresa.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {

  String selectItem = "";
  Map<String, dynamic>? selectedItem;
  final String codeUrl = "geturlMenu";
  int code = 0;
  List<Map<String, dynamic>> drawerItem = [];
  List<Map<String, dynamic>> contentItem = [];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? companyData = GlobalData.companyData;

    return Scaffold(
      drawer: Drawer(
        child: MenuBarHeader(drawerList: drawerItem,
            onMenuItemSelected: _onMenuItemSelected
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2),
                BlendMode.dstATop,
              ),
              child: Image.network(
                companyData?['urlFondo']?.toString() ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'lib/src/img/fondo.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Column(
            children: [
              HeaderHomePage(menu: contentItem,
                onPreviewGenerated: (item) {
                  setState(() {
                    selectItem = item;
                  });
                },),
              Expanded(
               child: selectItem.isEmpty
                 ? Content(menu: contentItem)
                 : Empresa(menu: contentItem),
                // child: selectedItem == null
                //     ? const ContentHome()
                //     : PageSelector(
                //   drawerItem: selectedItem!,
                //   onClose: _resetSelectedItem,
                // ),
              ),
              const FooterHomePage(),
            ],
          ),
        ],
      ),
      floatingActionButton: const FloatingMenu(),
    );
  }

  @override
  void initState() {
      _cargarMenus();
  }

  Future<ApiResponse> _cargarMenus() async {
    Map<String, String> replacements = {"code": "homepage"};

    final ApiResponse response = await Utilitarios.realizarPeticion(
      tipoPeticion: "GET",
      codigo: codeUrl,
      parametros: replacements,
    );

    if (response.code == 200 && response.body != null) {
      final data = response.body;
      code = response.code;

      setState(() {
        drawerItem = List<Map<String, dynamic>>.from(
          data['menu']?.where((element) => element['active'] == true
              && element['tipo'] == 'A') ?? [],
        );
        contentItem = List<Map<String, dynamic>>.from(
          data['menu']?.where((element) => element['active'] == true
              ) ?? [],
        );
      });
    }

    if (code != 200){
      MessageDialog.showMessage(context, title: "Home Page",
          message: response.message, confirmButtonText: "Aceptar");
    }

    return response;
  }

  void _onMenuItemSelected(Map<String, dynamic> selectedItem) {
    setState(() {
      this.selectedItem = selectedItem;
    });
  }

  void _resetSelectedItem() {
    setState(() {
      selectedItem = null;
    });
  }

}