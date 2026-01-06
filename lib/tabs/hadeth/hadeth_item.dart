import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/hadeth/hadeth.dart';
import 'package:islami/tabs/hadeth/hadeth_details_screen.dart';
import 'package:islami/widgets/loading_indicator.dart';

class HadethItem extends StatefulWidget {
  int index;
  HadethItem({required this.index});

  @override
  State<HadethItem> createState() => _HadethItemState();
}

class _HadethItemState extends State<HadethItem> {
  Hadeth? hadeth;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    if (hadeth == null) {
      loadHadeth();
    }

    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(HadethDetailsScreen.routeName, arguments: hadeth);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: .circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/leftheader.png',
                    width: screenSize.width * 0.15,
                    height: screenSize.height * 0.1,
                    fit: .fill,
                    color: AppTheme.black,
                  ),
                  if (hadeth != null)
                    Expanded(
                      child: Text(
                        hadeth!.title,
                        style: textTheme.titleLarge!.copyWith(
                          color: AppTheme.black,
                        ),
                        textAlign: .center,
                      ),
                    ),
                  Image.asset(
                    'assets/images/right_header.png',
                    width: screenSize.width * 0.15,
                    height: screenSize.height * 0.1,
                    fit: .fill,
                    color: AppTheme.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                width: .infinity,
                height: .infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/hadith_card_background.png',
                    ),
                  ),
                ),
                child: hadeth == null
                    ? LoadingIndicator(color: AppTheme.black)
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemBuilder: (_, index) => Text(
                          hadeth!.content[index],
                          style: textTheme.titleMedium!.copyWith(
                            color: AppTheme.black,
                          ),
                          textAlign: .center,
                        ),
                        separatorBuilder: (_, _) => SizedBox(height: 4),
                        itemCount: hadeth!.content.length,
                      ),
              ),
            ),
            Image.asset(
              'assets/images/footer.png',
              width: .infinity,
              color: AppTheme.black,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadHadeth() async {
    String hadethFileContent = await rootBundle.loadString(
      'assets/texts/h${widget.index + 1}.txt',
    );
    List<String> hadethLines = hadethFileContent.split('\r\n');
    String title = hadethLines[0];
    hadethLines.removeAt(0);
    List<String> content = hadethLines;
    hadeth = Hadeth(title: title, content: content, num: widget.index + 1);
    setState(() {});
  }
}
