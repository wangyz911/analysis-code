/*
 * _coder_mandelbrot_count_info.c
 *
 * Code generation for function '_coder_mandelbrot_count_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"
#include "_coder_mandelbrot_count_info.h"

/* Function Definitions */
mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 3);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("mandelbrot_count"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(3.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", emlrtMxCreateDoubleScalar
                (1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", emlrtMxCreateString(
    "9.3.0.713579 (R2017b)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  const char * data[25] = {
    "789ced5d4d8c1b49157642369b680904c28f5604767641519628e3f15f6ce7c0c67fe39ff9f1cf7826b6a368a6ed6eb73bd37fee6eff0d421a096977913870e2"
    "c411098440820b5a692f738cc4192490387040429ce0b2124248b4dd7e336ec71577d2edf6744f3d69d4ae7a767d556f5ebd57fdaafab5e75276eb92c7e3f982",
    "fa37bcdefdb3674437b48be7e6f87ad9a3a769fea5f1f53b5365a0373c5774bf03fecfc6d786c02b545fd10a2cc353db1dae4e496a812738eab41952e0189ee0"
    "95f240a43c12250b6c9722479c26c3526586a33685894286510bdcfa04ebb430640d3f275a54e370a7c379a4967cd65d76b2e09990cf2788f15f31289f12423e",
    "37c775c07f927a9a7ae82578821dc88cbcd21048ca4b120a711faaee3705e93e47d03ca5dc577a14754449b2b7d12189158592152f47f024c5d62541d96f081d"
    "5e59e5f4e33840f4f3aac1714c5f81ae7bae4d8eea11e0f511ed1995db9710782037e0531cbbcf29eaff57de6f51ac38d2a021cd1bf7bc7e4c13aa1f4056e9cb",
    "ce1c3ce03fc96e56524f930fbd0549a025825b19eab6ecdd8a953763716fc9bfe60bd7bd8a20b075a1ef5585e46599baaa240a4bd4bd82287b5f90db58616cd4"
    "971ffde12f7f8cd9ab9f76cf87e5e1999d7f5f43e0811e029fac0d8860bd41549241227624a4cadcb3aab87ed68fc21c9c79fdf020ca76b5ff1cf17ba3722410",
    "ed831c81bf80f9fc6e43e03881df6f0c3d1eb837189788e8b7517dbc3c5506ba3ef5fd111def3cd23e944ffdc331a27da3727d07810f7205fed0914aab8cbad8"
    "905447bacac8f10ec32a595e5d6e5012d330ed2700ffea54f9ac3f574775a4d0a9b394757ea282c4d3ea80ffca7a35fcbb37929af71e88cd3b2db655ce3ebb76",
    "fc11f613cef713f96e3b116b66ba9172313868a438debf5e6333eef113f83e61f61548af7fb72dbb4fb885c003b9015ff303b4d8593d544d1ac5363bfca8dea9"
    "f7097b73f080ff246bdcfccb2d42a248af66fcc72e607c5105e73d15dc50676cd497bfafbff5276cff17846797fda73387f59ab216ae67c3212635c8d0bec7d9",
    "6802dbff0b389fd525ddba65f6ffeb083c901bf0cfec3f4d2969b193e209753d4e2ecdfe9fbc261eb4559b83077c0bf54527b825ac1bbed70a633fe0743f90df"
    "2ecab952c51fec84cafd182f8aed5e3eefa27811be0f987d05d2ebdfdd4766ed2fb4ff3904de4d9533ac23ea5a046c59f19e5f9ac44b23f1b43ae09b89238e16",
    "035e5552aa32d818dff9fcdd3b38bee374bbdeaed7c96650ace7cb851da928f8d269763318778f5dc7f3574f7a7d5bc1717d8f35fe1fc7f51785a7d145c1c371"
    "7d6bdac7765f4f7a7d5bb3cceebf8dc00339017fcaeecb0d8225a45558dd3b379ebfb0733f33edfe3d4d6e639d991cc701a29f16dafdbffee621b6fb4eb7fbcf",
    "42e9224d16f7b2d1f56d5f74af5e0cd1cd828be2f9d8eeeb0965f73f46b467544eef21f0404ec09fb2fb8428b2839d91115beff00d8511b4eddcb9e79b8cf6eb"
    "8b73fa05fce6187dbf45f0a47a2360557cffc91c7ce05be30f6688d3fef3a0e9bf3dc0f17da7fb85588156f8603f541649b194dd2c4ab5ed5ad8457ee104f17b",
    "3caff5a4d7c3ac65f709df44e081fc803fe52f3a325520a4a62025045e1e3e7562557ce8ca54f9ac3f5746758d16317a24c1fe730256e88f5e6cf69e1338feb6"
    "0ffb03c7fb83419b13a395688e0dee31ad2215cff4bbdd6ad23dfe00cfe7d95720bdfe452cf303df40e081dc803fe507d422c3d3eb82942eec8ef84e8d1795e7",
    "e001df1abd99149bb680b0d10ffc700dfb01c7fb8156204c47e95e4aa176f63a052e44170af1bc8bee0bf07c9e7d05d2ebdf2a3efff99a78d0163effb970bc11"
    "5d143c7cfed39af64f10bfc7f1213de99f072859765ff02d041ec80ff8c3e7a55531ecabf742ac2088fb4297929aacd0d39e965ede7dc1c96be2415b0753e569",
    "3ce09bda77d2d4e925f2b3f51cd18f3f7d03fb05a7fb057923d54f258f8e0ab9be3fb8e55f4b1463beb5947bfcc23f10bf372ac70f11ed831c81bfe879fdeecb"
    "bf709a84c75e7d4d5bf61cc1bc783e23378739a62c9b1faf76ff7276de9527a97e96572c3bafb03ea71fc07f2dfd6a327d8a1405b5f7dea1fc6c8e3b7e8ccf99",
    "3adf3fec0c44860bb54b8f7d4c9d0c666bc5c296afeba27d043c7ff5843a6f2422da332aa71b5365cfc4f72e4df01999d78ec42bc3cc83cbdb2ffead49bc3c12"
    "4fab03be79bd989097bde7d1fef3fedbd8be3bddbea70387839d36cdb08972e2b0d48ed3e5c3dd948bec3b5effebc7b5a8f345283cab9ef75287ce117de7fa83",
    "1c124fab03beb973c9ea07af2629fbf7098eaffcf31a8e0739dd1f48ed35f119230763dc8342982fd42b818d3dd945cf13637fa01f97b5fb09f6fa0386c7fec0"
    "983f60f825f88337b13f70be3fa0896a381f78bcdd0ed7634a2244e48354b098768f3f3841fc1eef1beb49a78727d6ed1b9f97e78f8dfa1dabf34ee0e78f1785",
    "a7d145c1c3cf1f5bd33e9ecfb3af407afd0b59769ed4a8fe4df9813ec912e2c0bf3cfb7f6ef70966eacb585cf6ee13fce2d7d8ee3bdeeecb0d5f60b7d2ac27a2"
    "54a45c084bb5bd6eb4eca2f3a3387fe8ec2b10ea3902149e55f94359811e959765df9d938f449594bd76fd06ce1fea7cbb9eccc6fde4e3564ca8f4c285183d58",
    "8b08cf1ebb28be83e7af9e5079a08f11ed1995d36d041ec809f82fe40f4d0a1cc1f029491274f175d1647fcce61132bb1ed89d830f7cabf2894e8871b424b051"
    "8fb8dfc7719cffbcfa81af22f0400f81cf6e6dd553be4022d4631a8d942c765b557ac3e31e3f80e7f3ec2b905eff1e58b6bebf3655f69c7eefdaa88e91659190",
    "64caa9f19b6d249e56077c33eb83a184862b049095cdf98084e867789d7f5eedbbd1757e882d657ac256241dd8cdd0e146e22857caeeb8e85c0f5ee7eb49af6f"
    "dfb52c4eff15041ec809f853eb7c6a7a7d7f60b21f76e77f5bc8fb015e92f8e1742940694b001bed7dfee777f07adee9f69e2f578b84bf9aa905badd4eaad2f5",
    "05b81ce3a27d5a6ceff5743edf0f00d17be7e67b5bce7ebea63393e33840f4d342bd79fee10ab6fb4eb7fbd122115da33a1bdbedd26e26d2130f79ae1570d1f3"
    "5cd8eeeb0965f77f8268cfa89cde47e0819c803ffffd0059bec0120d6afcfdf312df7f6e12bf3e071ff80b3bf73b16eb12f6ff6f3d09613fe1743fb199db6854",
    "db8568acba159464bfc8f8bbe19c8bfc049edfb3c7654c1fcfce75a2f070fc5f231cffb71a4fa38b8287e3ffd6b48fedfdec7119d3c7b065f122fc9e18149e56"
    "e79ef74ae0f7c42c120fbf27c69af6b15f983d2e63faf881657e01e7877e391ef0717ee8d7c5d3e8a2e0e1fcd0d6b48ffdc3ec7119d3c747aedb6706fc8b9107",
    "02ef33bb0d0fef335bd33e9ecfb3af407afdbb6dd97ec19b08bc9b2a67582751043b4c04baacf890d9fd820d249e56077cf379dfc692b23fcfcf1ecefbe67cfb"
    "7e94decbf95bc960b953f4f5fccc606b37b4d972d17e019ec7b3fbafd7bb87a7765d44b467545e6f21f0405ec01fc62fc0c60fc9a9fb00aff2bc40c19c828812",
    "d32514ca3b213a3be33c9effe2f70038dfdeb33bdbf45ab514f095437b475d329f8b347b3cceef7311e7b34a2bcb8eeb34598150b6d43a76cc77aa1f309c17ca"
    "92fbc033b12d21dff367d80f38df0f7423816098ca6de49bc9a8520b13a5cd04c365b01f80f6705c47df9e55e740398964ba0ce9d873a076e4f31744d90b725a",
    "1ddf90d9a80f3ff8dd5357c775feb74cff65579e9f7eb5564bd131466a07bb5c2a54aec68acf088f7bec3b9ec7b3fbafd7bb7f7d605bbc5e1be6d2f665cdea43"
    "1689a7d501dfac3e803a8c97ed76aedbbfffef025eb73bddae477ac5e66e25f8209ce9b2a5683212d914761b1e6cd7cfcb3c46c5cf8deadd6544ffaf4f7d5fa3",
    "f71e69d73b96c571de41e083fc80ff427ecf788761952cbfadbda5d6b1e7731692ffe725f9fff462b3f5dce647f8bdede7d71f188de3e4bbed44ac99e946cac5"
    "e0a091e278ff7a8d75511cc7e9fee000d1bf45e57d3b46b467545e2b083c9017f0679ccfa4fa6242e0444261548bbc2cfb7f6212af8ac4d3ea806f8dfd7f416c",
    "cbd09f5ffdf496abe33d4bc5b3cb0fb44851aa558e520d3a9cdc0c0f021d22568ce0733c17cc0f9c9de331ab775f46e081bc803fe507d4d16bf54e8d032decbc"
    "d74cfbaf8acbfefd1e6cef178867dbfb7ae3f101190ea452b5bebf9bd92833c9aa5472c1bafffffeb8f61f",
    "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 55616U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_mandelbrot_count_info.c) */
