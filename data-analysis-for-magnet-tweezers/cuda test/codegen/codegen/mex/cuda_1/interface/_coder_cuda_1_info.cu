/*
 * _coder_cuda_1_info.cu
 *
 * Code generation for function '_coder_cuda_1_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "cuda_1.h"
#include "_coder_cuda_1_info.h"

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
  xInputs = emlrtCreateLogicalMatrix(1, 2);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("cuda_1"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(2.0));
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
  const char * data[21] = {
    "789ced5d3d6ce3c815e61ebc7b7bc5258b249720c8dfeee170b864b1a6f563cbde2267d9a22d59d6bf6ccbda6c6c4aa2a439931c8aa464c9411057c91641ca54"
    "29531c9226e902a471912248eabb224891224590eaae3924458090a2469608cd49bb1c53223d032ca8d1a3e79b79fbf8bdc7373f62ee2452771886f9026395f7",
    "3eb4ae6f1afffef313867930f8fe3566bcd8e57706d76fdaeaa8dc6596867f372affd5e05a85b22e7475ab22025948b7a58aa01a1599978461333528019997f5"
    "624f111855d0a0d8116a7d491d88421148c23e1ca9c4815191764644c38a29323f6f3785ea59a12d316a53bbeeae385a6146f4f3e1c8f8cd31a0f12f4dd0cfa8",
    "1c8d378ed18f799fa94f247fc63de79eb2bccc8b3d0d680fabb026b0355ee79fa0af9ed4a1fa44e21bb2a03fd1cf05e1425035b6daaef10f7541d3fb9f4e02cb"
    "12eab732d22f8467967b13fa3d2a47fd7ccd5647e50ddbfd567967d3ba863611fe29a6fd497a9b847fcf566786f7ddebeb4d52e0b9692e6ee1d560bb220a93ed",
    "e255f066b68bc47e897b1e7bca6655d85079e9a169c31a9b8a16f7a35b6c3eb8128854581d42b102bbac2089ac082aacc4eb225f61a1a2b1969eaeede214d3af"
    "59edc27e45e50de6fee0d365f259f0e3a87b7856b92d785d4c7bb3dadd573178c8ee90bc256fa40b79087be7d9f55d3e509663b02270d7fdc84ec199d60f0653",
    "77ab7daf3ebfeef2facaa6750d0e79fd12d3feac7afb0e061fe90dc94d07a82e032348500d07b80cb4ad3610f5846c8409820aaa73e3fd3f38c42b61f1acf123"
    "f94bdb8df9ef715f6bec63a436d6ae3657fdc0cffefab78fa81fb8213cb7fc40a6d3da8ed6e39df5622edcab72921cdc298b71ea07e6ed074e31fd226b6fef13",
    "8be7efdbeaccf0befb7d3d01cd18ac0abaf3e2f5df39c4dbc7e2597680e44eec40108d0f2cd2d4b264b6e7a23dfce54f94cf3dcfe71dbd9a52013c90568317f2"
    "d9e1fec679aa14dfa17c7e3bf83c468ccfef62f01e1812534f83f48c67f333bb583ccb0e90dca91d0cccc045deb9fcc16fd7687ec6eb3c7ed43c14d60ab9c26a",
    "be986b9762c9f2212c1c6c531e9ff7f3eb6e7ee6ed4debfa2ecdcf0cbea7f999c95754687ec61d3c9a9f21d3bed3f7f2acadce8cdc67ea11c909f981477551ef"
    "7f74d5ee2e539ba4ecee6b183ca42f24b7f1bf56e5455ee51a73e3fd85b59389bc8fd4e52adf4bdadf29df7b9def57d2e711a908a47212e46b5c32562dd4ebbd",
    "2dcaf7b7e73966c6f81ef7be31abbedeb4d59991fb4c7d2139d0642b44d5cd9558f3cbeb38b58f0c16cf1a2f92bf523c50075da1a640c33cd8317db99adf61fe"
    "fbddaf539ef73acfef86ce7a85560388dbc5edb37c6bab513c3be06294e76f2bcfe3f0c8cdbfd681f13ad3f42aafef61f12c7b4072e7bc6ee9c99a7d75958728",
    "afdf209e535e7f0b8387ec0fc93b2d81533a556da3741e8230ab1502a1e332e31f5ef756fef59ad71fd581aae975e0aafd5d9d12cbdb7f1b8387f486e4861a4e"
    "8ce19fd4a12a42a89cc08ea0d645787e5235f745388febed05d71f5410ded52be2a1f64f6d753b1e923b5a7f6399d1e7e8cfd57ccecfff7897cee32eaa3f9835",
    "ced7925c978b5d5c64f7bac1702ab8b29d8b06567cb4cefe5f98bf9f558f3fc5b48ff488e437fd5c3ffafc1b4e9a82a8ccb21f89acbdee127b3f58b2d599e17d"
    "4bc3f703b33ee7790620d7846e42d689ad13d899d20f2427f1de60be33b8681f2fe8fcaef7fd43a1a70069b5953f0a804a2d9c28e7b2a940c7477920fafc8e97",
    "717b5bf14d9e7f9a7fa9367973b928cdf363aea8d07c903b7834cf4fa67d1aff8f8f8bacbd265c3b6fc118bac477bdeb0f6e747e607c7f565f53eecf0f5c2efd"
    "fb3ecd0779dd1fa8ad15e503a085a3d25a3622672ba550f250f3d1fa1eea0fc6c74576bed85d7f0064ea0f66f307409e833f789dfa03effb83067f1cc9848ed2",
    "ad4825aa6faff299b010ceedfac71fd0f9e2c95754c6ecef1fa7c4f8fd65f3fd4ef1dcdebfebe3bc20cdebdf201ecdeb9369df697c96b5d59991fb7cb36f8bb9"
    "5edff902d3deacfa7a0f8387f485e4b6f9545e51c4de169079b557e8fbb69db65cd5019449cd3b7c714abf90bc3ec03d69f272cd700408ffcf0ef1f929f8484e",
    "263ec0aa1385ff6ec6ff1bffa4e73c78de4f5c083c8ccae950596f3482bb2ba94cede028e0233f7185f9fb59f558c6b48ff488e4a4fc84f50670521721af9fa0"
    "436e1897edf0aa4cf7fb3ac4bbb1f86261f68fd0fdbe378947f7fb9269df69fee708d33ed2239293e27f19ea693e9d5113c6a3dd30c8dfddfcfe11b1fccfb4f3",
    "db8026f332e3dd7dbe092c9e6517484ee23c4e4353f388ef691ee806f1dcda0fd68ab63352b8570aafe4d5607b3b206c74a434e31f7ea7cff1e4fe8fdbdd3bc4"
    "f681d1f3db7078f4fc36677856b92d78f4fc3632edd3f87ef215155c7c7f89696f56bd7d038387f486e413f33acb7511422bb1e5553f7080c5b3c68fe464fcc0",
    "634b6f6c5f6ffd18c2453ff019dd07e07d3f5069ae654bb2a8d70a50e2da723c54e1b6f67cb4ce6761f3b58b341f7c992696d7ff0a060fe90bc96dfc2fa82a1c"
    "5b6779eab01f2fbbae7321e37fcde8a450632dd61f70bfdd05f435e76afc9ff9f5bb747ed7ebbc2f178f737cf0385e0e753a6daed40984a43d40cff11fb637f3",
    "efb1d0dfcf1dc39b76de9ba4d64007d404afe6f7dd58bfdfff9d9e819e960706e1221ffdf8f7cf7dcdefff9be77b8b5bf9fdee71b9cc35a2406d853b12b75a3c"
    "8ee63ee019fff03b7d8e27f77fdcee3e799f14cfbe8ec17b60484c7d0d8649e76da7d803328739ccdbfee8d32ccdd7789dd7d7cf73f58352782d12ef88f98dd8",
    "fafa3e3ca83294d717e53976377e7f7bd3bad2dfe15ae83c0e9dc71d96db8247e771c9b4ef757f708ae91f59bbfb1e31fe7f88c143fa42f209f3b74257d98692"
    "c2ebc060e479f1ff9543bc632c9e357e2427b73e7f4c6df3b09fdffcf2cbbecef7cc15cf2d3fd0ac296ab974c1551b91d87ea4176af3d1dcba8fd6eb533f30b9",
    "ffe376f794d83cee973078485f486ef303c6e8adefbd9a074a62f1ac71233919fe37d435b014caf7fec073ed7c9eadad5e2d12e2b87237d889278b2076ace67d"
    "14f77b75fef614d3af453d9f19f7ff82f484e416cf3794f6f299415d82e894dfed05878f0aa9fc4e610a1e923f4b1059a663288cb514e63ecfff42fa21e5f945",
    "e5f959f3fd7b402c654add62345bec1d14929d14dca9fb29df4f9fe7c95754c6d7692689e579be85c1437a43f26bde1fc6f8d6f813922232e4e2fc69f3cb226c"
    "802a2fcee17c1e6276731df65f6b102d0b70d38e9ebea07e6161fdc2acf17f3ea581043cabc739f94091d6dbedc30dbee8a37c0f7dbe278f6b367bbc5ef7e3ee",
    "393da69f6808faaed2e664be220a35c7fec15e667d4fb87a453cd4feece73b11b39f31c5cde1777ebfdf8c50bfe075bf9049e7b4bd7c29186eaf16bb5159515a"
    "e799cc8ef7fdc2ff01c856c88d", "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 43072U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_cuda_1_info.cu) */
