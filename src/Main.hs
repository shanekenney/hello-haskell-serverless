import           AWSLambda
import qualified Data.Aeson as Aeson

main = lambdaMain handler

handler :: Aeson.Value -> IO [Int]
handler evt = do
  putStrLn "Hello lambda logs"
  print evt
  return [1, 2, 3]
