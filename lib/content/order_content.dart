import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hike_it/constant.dart';
import 'package:hike_it/content/selection_content.dart';
import 'package:hike_it/controllers/order_controllers.dart';
import 'package:hike_it/session_helper.dart';
import 'package:hike_it/theme.dart';
import 'package:get/get.dart';

class OrderContent extends StatefulWidget {
  const OrderContent({Key? key}) : super(key: key);

  @override
  State<OrderContent> createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  bool isPendaki = false;
  @override
  void initState() {
    loadStatus();
    super.initState();
  }

  void loadStatus() async {
    isPendaki = await SessionHelper.isPendaki();
    // setState(() {
    //   isPendaki
    // });
  }

  Widget menuButton({
    required String icon,
    required String title,
  }) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: hitam.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Container(
          width: getHeight(40),
          height: getHeight(40),
          padding: EdgeInsets.all(
            getHeight(8),
          ),
          decoration: const BoxDecoration(
            color: putih,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        trailing: SvgPicture.asset(
          "assets/icons/profile/ArrowRight.svg",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        initState: (_) => OrderController.to.getOrderList(),
        builder: (orderC) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: getHeight(20),
                ),
                ExpansionTile(
                  leading: Container(
                    width: getHeight(36),
                    height: getHeight(36),
                    padding: EdgeInsets.all(
                      getHeight(8),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/dashboard/Document.svg",
                    ),
                  ),
                  title: const Text(
                    "Ongoing Orders",
                    style: TextStyle(
                      color: hitam,
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  children: orderC.mapOrderList.keys
                      .map(
                        (keys) => Container(
                          margin: EdgeInsets.only(
                            bottom: getHeight(10),
                          ),
                          decoration: BoxDecoration(
                            color: hitam.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ListTile(
                            leading: ClipOval(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "$baseURL/${orderC.mapOrderList[keys]![0].tempatWisata!.pictures![0].path}",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  width: 50,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            title: Text(
                              orderC.mapOrderList[keys]!.isNotEmpty
                                  ? orderC.mapOrderList[keys]![0].tempatWisata!
                                      .nama!
                                  : '',
                              style: const TextStyle(
                                color: hitam,
                                // fontSize: 20,
                                fontWeight: medium,
                              ),
                            ),
                            subtitle: Text(
                              orderC.mapOrderList[keys]!.isNotEmpty
                                  ? '${orderC.mapOrderList[keys]![0].tanggalMulai!} sd. ${orderC.mapOrderList[keys]![0].tanggalSelesai!}'
                                  : '',
                              style: const TextStyle(
                                color: hitam,
                                fontSize: 11,
                                fontWeight: light,
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                // orderC.terimaOrder(order.id.toString());
                                Get.to(SelectionContent(
                                    listOrderGroup: orderC.mapOrderList[keys]!,
                                    orderId: keys));
                              },
                              child: Container(
                                height: 32,
                                width: 64,
                                padding: EdgeInsets.all(
                                  getHeight(5),
                                ),
                                decoration: BoxDecoration(
                                  gradient: gradient,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Detail",
                                    style: TextStyle(
                                      color: putih,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Divider(),
                ExpansionTile(
                  leading: Container(
                    width: getHeight(36),
                    height: getHeight(36),
                    padding: EdgeInsets.all(
                      getHeight(8),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/dashboard/Document.svg",
                    ),
                  ),
                  title: const Text(
                    "Pending Orders",
                    style: TextStyle(
                      color: hitam,
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  children: orderC.pendingOrderList
                      .map(
                        (order) => Container(
                          margin: EdgeInsets.only(
                            bottom: getHeight(10),
                          ),
                          decoration: BoxDecoration(
                            color: hitam.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ListTile(
                            leading: order.pendaki?.profile != null
                                ? ClipOval(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "$baseURL/${order.pendaki?.profile}",
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        width: 50,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  )
                                : ClipOval(
                                    child: Image.asset(
                                      "assets/images/profile/ArunaSentana.jpg",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                            title: Text(
                              order.pendaki!.nama!,
                              style: const TextStyle(
                                color: hitam,
                                // fontSize: 20,
                                fontWeight: medium,
                              ),
                            ),
                            subtitle: Text(
                              order.tempatWisata!.nama!,
                              style: const TextStyle(
                                color: hitam,
                                // fontSize: 14,
                                fontWeight: light,
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                if (isPendaki) {
                                  orderC.cancelOrder(order.id.toString());
                                } else {
                                  orderC.terimaOrder(order.id.toString());
                                }
                              },
                              child: Container(
                                height: 32,
                                width: 64,
                                padding: EdgeInsets.all(
                                  getHeight(5),
                                ),
                                decoration: BoxDecoration(
                                  gradient: gradient,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    isPendaki ? "Cancel" : "Terima",
                                    style: const TextStyle(
                                      color: putih,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        });
  }
}
